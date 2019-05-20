Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F132C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732A5216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWOX6NrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfETO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:56:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbfETO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:56:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so7339933pfo.11;
        Mon, 20 May 2019 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=O3kXD3ITk26oSSwgybzR3DA5D7KEBzcJ5ceoicOhdOc=;
        b=UWOX6NrEQM65f8yYWtG3hrWSu+9eksyHelP7U35bP5SE9k8LSeuZaS0IaJbyV2joDp
         XeF9a42UIjCEj6E3L86E+N91GPBmgrqxjrK1Y4R6G352RYsyAJBgZk9H4RdOGsUFeKjW
         a/mFno/1qZyan/M8yy2/0jEeOC38fDIyYHWDLW+6PwPCogj6c9Dzr8eDYXjPXp4HMXRf
         ByHpwBkeUD2tSezpumbyB7+pnCFr+rDWrthbJT5GYiYiAqMUFC4ZPMyaDcl5BZYKlwRE
         ikNdp749WVWXMA592QdyJpN5/K02GtR0jOMUdf77PS/AB+9+uA4mGP8eQaA8H++7Nveb
         Drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=O3kXD3ITk26oSSwgybzR3DA5D7KEBzcJ5ceoicOhdOc=;
        b=XsT2oNCuzlZXkI/GUcncgCWh2N2gH2H/KA64qcfnssLJrN1+oBESjZlXx1V/+wzoAQ
         Sq6kpV1b9mfTL/1dUIqdRAZp7GehaVGWOFtI4IK1osprH5iYQx35Z0m1jebLfMbHlq8H
         H+Z5GvYTfdQmEjlqHxQVb5SWsNnSzCv9pygglbOYxi2dxEaTI/q7ZTYwBTpFXYubF1+E
         k1HLXzwUS4n622y3vpYNHT+a5mYsvfUcuVj20RfVyMsfk0Hpdht7InpKGJnHj7gk5t43
         XcmVtUu1C+ezZlQHJIDDo/2zDC2PXvycuC09QECGqWHaYaDgl6EURRzMQoo2my9FH1jc
         wsXQ==
X-Gm-Message-State: APjAAAVxF0U4TQZR5MKa1k9OocA58YD0oYiVyqSvIOidM+E8NVjpCQ6t
        eyy1pwz9JIDCErb7vqH/acY=
X-Google-Smtp-Source: APXvYqx2hkmlDblKAZscUFiS/KNuLl3PIT6eGhZM/LWHjV/4nRDBV7z+Y/WaRRVZubAjfRObVnJt5A==
X-Received: by 2002:a62:7608:: with SMTP id r8mr780980pfc.190.1558364214465;
        Mon, 20 May 2019 07:56:54 -0700 (PDT)
Received: from localhost (193-116-79-244.tpgi.com.au. [193.116.79.244])
        by smtp.gmail.com with ESMTPSA id t7sm20650667pfh.156.2019.05.20.07.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 07:56:53 -0700 (PDT)
Date:   Tue, 21 May 2019 00:55:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: PROBLEM: Power9: kernel oops on memory hotunplug from ppc64le
 guest
To:     bharata@linux.ibm.com
Cc:     aneesh.kumar@linux.ibm.com, bharata@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        srikanth <sraithal@linux.vnet.ibm.com>
References: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
        <20190518141434.GA22939@in.ibm.com>
        <878sv1993k.fsf@concordia.ellerman.id.au>
        <20190520042533.GB22939@in.ibm.com>
        <1558327521.633yjtl8ki.astroid@bobo.none>
        <20190520055622.GC22939@in.ibm.com>
        <1558335484.9inx69a7ea.astroid@bobo.none>
        <20190520082035.GD22939@in.ibm.com> <20190520142922.GE22939@in.ibm.com>
In-Reply-To: <20190520142922.GE22939@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1558363500.jsgl4a2lfa.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao's on May 21, 2019 12:29 am:
> On Mon, May 20, 2019 at 01:50:35PM +0530, Bharata B Rao wrote:
>> On Mon, May 20, 2019 at 05:00:21PM +1000, Nicholas Piggin wrote:
>> > Bharata B Rao's on May 20, 2019 3:56 pm:
>> > > On Mon, May 20, 2019 at 02:48:35PM +1000, Nicholas Piggin wrote:
>> > >> >> > git bisect points to
>> > >> >> >
>> > >> >> > commit 4231aba000f5a4583dd9f67057aadb68c3eca99d
>> > >> >> > Author: Nicholas Piggin <npiggin@gmail.com>
>> > >> >> > Date:   Fri Jul 27 21:48:17 2018 +1000
>> > >> >> >
>> > >> >> >     powerpc/64s: Fix page table fragment refcount race vs spec=
ulative references
>> > >> >> >
>> > >> >> >     The page table fragment allocator uses the main page refco=
unt racily
>> > >> >> >     with respect to speculative references. A customer observe=
d a BUG due
>> > >> >> >     to page table page refcount underflow in the fragment allo=
cator. This
>> > >> >> >     can be caused by the fragment allocator set_page_count sto=
mping on a
>> > >> >> >     speculative reference, and then the speculative failure ha=
ndler
>> > >> >> >     decrements the new reference, and the underflow eventually=
 pops when
>> > >> >> >     the page tables are freed.
>> > >> >> >
>> > >> >> >     Fix this by using a dedicated field in the struct page for=
 the page
>> > >> >> >     table fragment allocator.
>> > >> >> >
>> > >> >> >     Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory was=
tage")
>> > >> >> >     Cc: stable@vger.kernel.org # v3.10+
>> > >> >>=20
>> > >> >> That's the commit that added the BUG_ON(), so prior to that you =
won't
>> > >> >> see the crash.
>> > >> >=20
>> > >> > Right, but the commit says it fixes page table page refcount unde=
rflow by
>> > >> > introducing a new field &page->pt_frag_refcount. Now we are hitti=
ng the underflow
>> > >> > for this pt_frag_refcount.
>> > >>=20
>> > >> The fixed underflow is caused by a bug (race on page count) that go=
t=20
>> > >> fixed by that patch. You are hitting a different underflow here. It=
's
>> > >> not certain my patch caused it, I'm just trying to reproduce now.
>> > >=20
>> > > Ok.
>> >=20
>> > Can't reproduce I'm afraid, tried adding and removing 8GB memory from =
a
>> > 4GB guest (via host adding / removing memory device), and it just work=
s.
>>=20
>> Boot, add 8G, reboot, remove 8G is the sequence to reproduce.
>>=20
>> >=20
>> > It's likely to be an edge case like an off by one or rounding error
>> > that just happens to trigger in your config. Might be easiest if you
>> > could test with a debug patch.
>>=20
>> Sure, I will continue debugging.
>=20
> When the guest is rebooted after hotplug, the entire memory (which includ=
es
> the hotplugged memory) gets remapped again freshly. However at this time
> since no slab is available yet, pt_frag_refcount never gets initialized a=
s we
> never do pte_fragment_alloc() for these mappings. So we right away hit th=
e
> underflow during the first unplug itself, it looks like.

Nice catch, good debugging work.

> I will check how this can be fixed.

Tricky problem. What do you think? You might be able to make the early=20
page table allocations in the same pattern as the frag allocations, and=20
then fill in the struct page metadata when you have those.

Other option may be create a new set of page tables after mm comes up
to replace the early page tables with. That's a bigger hammer though.

Thanks,
Nick

=
