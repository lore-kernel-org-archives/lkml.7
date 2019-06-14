Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08497C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEE121473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mXKFBZox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfFNLHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:07:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfFNLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:07:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5EAwmvT165809;
        Fri, 14 Jun 2019 11:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=O7+0XmsefPevyig0tjNZbgvZOwX40mkvK1LDHP5RRU4=;
 b=mXKFBZoxF3m3dCYLvh8i7oPyAyIX+0ZqosSH4jW1pUayynj9QoeqqvnVQXVyWLuVcVgQ
 X2ttvgBXnoD6gk2DvC7OThUYy2QM2MUQzAh12BPHIX21JQPYThnwC5kYRbTqcywwq2on
 tZMzGqWbZ1tMuKlRcdMXLq5wI9CSQSZz0GLX5HJES2hDofR8pclVK+8nQapjLVMAZX94
 bl8q7qQKlJ4nnPo7LX6bmqCdWaMfXu0ENoBXkpovflHeF3Ys2sZ2RZNYIFTiSYMXkgSL
 uxztPXKc/ZGCcksBZ3glSJAxN2iYWJzfY1a80hOmt6jMh0Wvga4+z3OxRCGseA5xovyv vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nr6t5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 11:06:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5EB6uqv194764;
        Fri, 14 Jun 2019 11:06:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t1jpk38yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 11:06:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5EB6tYS005116;
        Fri, 14 Jun 2019 11:06:55 GMT
Received: from tomti.i.net-space.pl (/10.175.219.193)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Jun 2019 04:06:54 -0700
Date:   Fri, 14 Jun 2019 13:06:50 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
Subject: Re: [PATCH RFC 1/2] x86/boot: Introduce the setup_header2
Message-ID: <20190614110650.ytg7dvyimstu2lis@tomti.i.net-space.pl>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
 <20190524095504.12894-2-daniel.kiper@oracle.com>
 <95fd235b-b4e5-c547-3625-b23ef66c5d4f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95fd235b-b4e5-c547-3625-b23ef66c5d4f@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906140092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906140092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on new version of patches but I have some concerns. Please
look below for more details...

On Thu, Jun 06, 2019 at 03:06:30PM -0700, H. Peter Anvin wrote:
> On 5/24/19 2:55 AM, Daniel Kiper wrote:
> > Due to limited space left in the setup header it was decided to
> > introduce the setup_header2. Its role is to communicate Linux kernel
> > supported features to the boot loader. Starting from now this is the
> > primary way to communicate things to the boot loader.
> >
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> > Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> > ---
> > I know that setup_header2 is not the best name. There were some
> > alternatives proposed like setup_header_extra, setup_header_addendum,
> > setup_header_more, ext_setup_header, extended_setup_header, extended_header
> > and extended_setup. Sadly, I am not happy with any of them. So,
> > leaving setup_header2 as is but still looking for better name.
> > Probably shorter == better...
>
> I would say kernel_info. The relationships between the headers are analogous
> to the various data sections:
>
> 	setup_header		= .data
> 	boot_params/setup_data	= .bss
>
> What is missing from the above list? That's right:
>
> 	kernel_info		= .rodata
>
> We have been (ab)using .data for things that could go into .rodata or .bss for
> a long time, for lack of alternatives and -- especially early on -- intertia.
> Also, the BIOS stub is responsible for creating boot_params, so it isn't
> available to a BIOS-based loader (setup_data is, though.)
>
> setup_header is permanently limited to 144 bytes due to the reach of the
> 2-byte jump field, which doubles as a length field for the structure, combined
> with the size of the "hole" in struct boot_params that a protected-mode loader
> or the BIOS stub has to copy it into. It is currently 119 bytes long, which
> leaves us with 25 very precious bytes. This isn't something that can be fixed
> without revising the boot protocol entirely, breaking backwards compatibility.
>
> boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
> by adding setup_data entries. It cannot be used to communicate properties of
> the kernel image, because it is .bss and has no image-provided content.
>
> kernel_info solves this by providing an extensible place for information about
> the kernel image. It is readonly, because the kernel cannot rely on a
> bootloader copying its contents anywhere, but that is OK; if it becomes
> necessary it can still contain data items that an enabled bootloader would be
> expected to copy into a setup_data chunk.
>
> ^ The above or some variant thereof may be a good thing to put both in your
> patch comments as well as in the boot protocol documentation.

Will do...

> While we are making a change that bumps the version number anyway, there is
> another change I would like to make to the boot protocol which we might as
> well do at the same time. setup_data is a bit awkward to use for extremely
> large data objects, both because the setup_data header has to be adjacent to
> the data object, and because it has a 32-bit length field. However, it is
> important that intermediate stages of the boot process have a way to identify
> which chunks of memory are occupied by kernel data.

Is not possible to "identify which chunks of memory are occupied by
kernel data" today? I think that it is. So, this does not look like
a valid point for change. Am I missing something?

> Thus I think we should introduce a uniform way to specify such indirect data.
> We define a new setup_data type we can maybe call SETUP_INDIRECT; a
> SETUP_INDIRECT data item would be an array of structures of the form:

OK.

> struct setup_indirect {
> 	__u32 type;
> 	__u32 reserved;	/* Reserved, must be set to zero */
> 	__u64 len;
> 	__u64 addr;
> };
>
> ... where type is itself simply a SETUP_* type -- although we probably don't
> want to let it be SETUP_INDIRECT itself since making it a tree structure could
> require a lot of stack space in something that needs to parse it, and stack
> space can be limited in boot contexts.

Yeah...

> This would be particularly useful for having SETUP_INITRAMFS, if it becomes
> desirable to allow the kernel to parse a non-contiguous set of memory regions
> for the initramfs.

OK.

> It might be a good idea to immediately start out struct kernel_info with
> either a high mark or a bitmask of SETUP_* types that the kernel supports. A

High mark seems better for me here.

> bitmask would be more flexible, but would need provisions to be grown in the
> future.

Yep.

Anyway, I agree with the idea but I am not sure it makes sense to
introduce something which does not have users right now. Does it?

> Which leads me to yet another thought.
>
> We probably want to make the contents of kernel_info a bit more structured to
> allow for content that may need to be extended in the future, or is inherently
> variable length (like strings.)
>
> This would lend itself to a structure such as:
>
> 	- Magic number
> 	- Length of total structure

My first proposal have both fields...

> ... followed by a list of data chunks, each prefixed by a length field. The
> first data chunk would be the main (root) structure; other data structures are

I am not sure that I understand the idea of the main (root) structure.
Should it point to itself?

> pointed to from the root structure using offsets from the beginning of the
> structure (the magic number field.)

Sounds nice but I think that it is an overkill in many simple cases,
e.g. look at MLE entry point. In case of MLE entry point we do not need
nothing fancy. So, I think that this filed should be a member of the
kernel_info which points directly to new MLE entry point. I can agree
that we can use the mechanism mentioned by you above in more complicated
cases and it can be described in Documentation/x86/boot.rst. But I would
not enforce it for everything. Just for the sake of simplicity.

> As an implementation detail, strings can of course be "pooled" into a single
> data chunk as long as they are zero-terminated.

OK.

> I have intentionally avoided specifying a type field for each data chunk;
> history shows that it is generally a bad idea to have multiple ways to derive
> the same information, as different implementations will do it differently,
> resulting in bugs when things change.

Make sense for me.

So, it seems to me that we have to have at least two patches:
  - one introducing the kernel_info structure,
  - another introducing the setup_indirect and bumping the
    boot protocol version number.

This thing has at least one cons: first patch introduces a new boot
protocol feature but it is not reflected in the protocol version change.
Not perfect but I do not think that we should bump the version number in
first patch. do you have better idea?

Daniel
