Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B18C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDKAsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:48:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:48:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F978ACB1;
        Thu, 11 Apr 2019 00:48:53 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Date:   Thu, 11 Apr 2019 10:48:42 +1000
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <20190410193418.GA32402@roeck-us.net>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown> <155416006521.9540.5662092375167065834.stgit@noble.brown> <20190410193418.GA32402@roeck-us.net>
Message-ID: <87r2a9xt79.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10 2019, Guenter Roeck wrote:

> Hi,
>
> On Tue, Apr 02, 2019 at 10:07:45AM +1100, NeilBrown wrote:
>> This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
>> bucket pointer to lock the hash chain for that bucket.
>>=20
>> The benefits of a bit spin_lock are:
>>  - no need to allocate a separate array of locks.
>>  - no need to have a configuration option to guide the
>>    choice of the size of this array
>>  - locking cost is often a single test-and-set in a cache line
>>    that will have to be loaded anyway.  When inserting at, or removing
>>    from, the head of the chain, the unlock is free - writing the new
>>    address in the bucket head implicitly clears the lock bit.
>>    For __rhashtable_insert_fast() we ensure this always happens
>>    when adding a new key.
>>  - even when lockings costs 2 updates (lock and unlock), they are
>>    in a cacheline that needs to be read anyway.
>>=20
>> The cost of using a bit spin_lock is a little bit of code complexity,
>> which I think is quite manageable.
>>=20
>> Bit spin_locks are sometimes inappropriate because they are not fair -
>> if multiple CPUs repeatedly contend of the same lock, one CPU can
>> easily be starved.  This is not a credible situation with rhashtable.
>> Multiple CPUs may want to repeatedly add or remove objects, but they
>> will typically do so at different buckets, so they will attempt to
>> acquire different locks.
>>=20
>> As we have more bit-locks than we previously had spinlocks (by at
>> least a factor of two) we can expect slightly less contention to
>> go with the slightly better cache behavior and reduced memory
>> consumption.
>>=20
>> To enhance type checking, a new struct is introduced to represent the
>>   pointer plus lock-bit
>> that is stored in the bucket-table.  This is "struct rhash_lock_head"
>> and is empty.  A pointer to this needs to be cast to either an
>> unsigned lock, or a "struct rhash_head *" to be useful.
>> Variables of this type are most often called "bkt".
>>=20
>> Previously "pprev" would sometimes point to a bucket, and sometimes a
>> ->next pointer in an rhash_head.  As these are now different types,
>> pprev is NULL when it would have pointed to the bucket. In that case,
>> 'blk' is used, together with correct locking protocol.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> This patch causes my qemu q800 boot test to crash reliably.
>
> Starting network: Unable to handle kernel access at virtual address (ptrv=
al)
> Oops: 00000000
> Modules linked in:
> PC: [<00248b90>] sk_filter_trim_cap+0x56/0x158
> SR: 2000  SP: (ptrval)  a2: 07a30aa0
> d0: 07836300    d1: 0783666c    d2: 00000001    d3: 0025c192
> d4: 0025a636    d5: 00248b3a    a0: 078363fe    a1: 60000000
> Process ip (pid: 66, task=3D(ptrval))
> Frame format=3D7 eff addr=3D6000000c ssw=3D0505 faddr=3D6000000c
> wb 1 stat/addr/data: 0000 00000000 00000000
> wb 2 stat/addr/data: 0000 00000000 00000000
> wb 3 stat/addr/data: 0000 6000000c 00000000
> push data: 00000000 00000000 00000000 00000000
> Stack from 07a5bdec:
>         07a5be5c 0025c192 0025a636 00248b3a 00000000 ef9febc8 078363fe 07=
87a2d0
>         0783645c 07a5be5c 0025c192 0025a636 00248b3a 0787a2d0 07a2c000 00=
25c470
>         078363fe 0787a2d0 00000001 00000000 00000000 07a5be98 07a17500 00=
000000
>         0787a2d0 07a2c000 07a5bef8 07a5beac 7fffffff 0025c7e2 07a2c000 07=
87a2d0
>         00000000 00000000 00000000 0000000c ef9feb14 ef9feb14 00000000 00=
31a52e
>         07a5bef8 07a5bf28 0000000c 0781eba0 00000000 00000042 00000000 00=
000000
> Call Trace: [<0025c192>] netlink_attachskb+0x0/0x138
>  [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
>  [<00248b3a>] sk_filter_trim_cap+0x0/0x158
>  [<0025c192>] netlink_attachskb+0x0/0x138
>  [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
>  [<00248b3a>] sk_filter_trim_cap+0x0/0x158
>  [<0025c470>] netlink_unicast+0x170/0x1be
>  [<0025c7e2>] netlink_sendmsg+0x288/0x2b2
>  [<0021a5be>] sock_sendmsg+0x1c/0x44
>  [<0021b8a6>] __sys_sendto+0xac/0xd2
>  [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
>  [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
>  [<00219906>] sock_alloc_file+0x50/0x80
>  [<000b7a1c>] fd_install+0x12/0x18
>  [<0021b1cc>] __sys_socket+0x7e/0x9c
>  [<0021b8ea>] sys_sendto+0x1e/0x24
>  [<00002a40>] syscall+0x8/0xc
>  [<0000c004>] ATANTBL+0x618/0x800
> Code: 4a89 6604 4280 60ea 2c2b 000c 2748 000c <2869> 000c 082c 0003 0002 =
6728 4878 0014 7620 4873 3800 486e ffec 4eb9 002e 5b88

Thanks for testing and for the report.
The above code disassembles to:

   0:	4a89           	tstl %a1
   2:	6604           	bnes 0x8
   4:	4280           	clrl %d0
   6:	60ea           	bras 0xfffffff2
   8:	2c2b 000c      	movel %a3@(12),%d6
   c:	2748 000c      	movel %a0,%a3@(12)
  10:*	2869 000c      	moveal %a1@(12),%a4		<-- trapping instruction
  14:	082c 0003 0002 	btst #3,%a4@(2)
  1a:	6728           	beqs 0x44
  1c:	4878 0014      	pea 0x14
  20:	7620           	moveq #32,%d3
  22:	4873 3800      	pea %a3@(0000000000000000,%d3:l)
  26:	486e ffec      	pea %fp@(-20)
  2a:	4eb9 002e 5b88 	jsr 0x2e5b88

And as %a1 is 60000000, it crashes.
I'm not familiar with m68k assembler, but a bit of hunting suggests that
  moveal %a1@(12),%a4

means "add 12 to %1, load an address from there, then dereference that
address again.
I think that both skb->sk and filter->prog are at offsets of 12, so I
guess
   8:	2c2b 000c      	movel %a3@(12),%d6
is
   struct sock *save_sk =3D skb->sk;

   c:	2748 000c      	movel %a0,%a3@(12)
is
  		skb->sk =3D sk;
and
  10:*	2869 000c      	moveal %a1@(12),%a4		<-- trapping instruction
  14:	082c 0003 0002 	btst #3,%a4@(2)
is
     bpf_prog_run_save_cb(filter->prog, skb);
                if (unlikely(prog->cb_access)) {

cb_access might be bit 3 of the byte 2 along from *prog, which is 12
along from a1.

That makes a1 'filter', loaded from sk->sk_filter, where 'sk' is %a0,
  078363fe

That address is 2-byte aligned, which is probably wrong.... If addresses
of structs aren't always 4-byte aligned, then using BIT(1) for a lock
bit isn't going to work.

.... and after googling a bit I see that 68000 require 2-byte alignment,
but not 4-byte.  Oh..

That means there aren't two spare bits in an address, so I cannot use
one for the NULLS and one for a lock bit.  Bother.

I might be able to find a different way forward, but for now I think we
need to drop this series.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyujuwACgkQOeye3VZi
gbnFYQ//dn4lgat/e++Mwvf3T56eTfcwHFSV5PnCqrTG+Y4eSvFGxZEAlMlIAtpr
ZGwRNC9ClokQo9Y3r/t8sJnldu5XRF6RslS+H81qLU9kDhxlTJGSAebRerR9XmAm
JSDdTskUvAwZpWZGW+7wFSmfWMW2rIBO6/2TM1wKLIpMeQ4y2JSNqRiJ+y43AtOJ
xoJO33ThPyNUdOJF50LZxU4zY9mYEQ05r1//LCPxBf0ybN8y49juS7FDjzXmB+9U
jBLQa1eoFzNlyzgUoq6VCh3iLNda2uytVxUXz7oehy6XAyjIpWUl8hxsajQvPJPj
VyFF/5IaBKZfcLz4mpQQYN7gDLdC0bEN5lYpnXrtDrGhDFW+xMxpDr5MiFDALi7U
TjY1FXnQUgpc04TnFHiSNZ0bWFN8TmOZ8lqTEQkgnAnbRx+h2VWIKEDxJElx/HMo
lpmrD5nUfOqRE7sUXIZJmPDtYcwHolYVCTPSh+ju53DsmgZAuouQIb5IJmLcHEJz
n6tc2ywjcogryc5cOAp/PrNAj7H940OxeL1ivNbIsHd7V4kiWT+esFVaIZtCzhk7
K502R9UdWPadIXdhhnH3XBmkSr2MuNemgWcbRqr4SCSmz0glNQmWnSgsGschaVAI
a1ANjvQNdvTOHrUPdW8kALH+Yy2wBbiqcv9/qMcQlyOAqOoaB7w=
=RjyY
-----END PGP SIGNATURE-----
--=-=-=--
