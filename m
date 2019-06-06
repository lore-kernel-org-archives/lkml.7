Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36626C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082602083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AiBbVniy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfFFWGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:06:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45719 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfFFWGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:06:47 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x56M6ZWp2158298
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 6 Jun 2019 15:06:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x56M6ZWp2158298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559858797;
        bh=Y/Jr6CNliji1kAb24oczEDrL2qxP44Q+9QVwOi6b+gg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AiBbVniyfQqP5N+4wCHxj0GHikCtN3vwHb9pOMlwAVJ8yysBWuQTBjWFCVfL3IR7G
         f7/IyEa97AaqQzSEHb9EaV8CgpwIk4r5DL64J0/TzoFD/FZgzhz/hgQ/sdDaxGPuMq
         F1CL4s5gggJRFAo4WtXcDu8vT3XpKZsVGQkzf+PmY7D9udfhUwdk7JMEYg530zZNlY
         kpZfMBwXY1KN1t1OOrAae4jbJc+SWjAOLx0o2IySL7GD0LBlT0uu+2RhTPpRG4+q9l
         X3b5gb8s+ipFL6ec0oX9cT1KPppz6zP7w559Sx8JCgoGQM89NcOd84p0n8qkyD7snH
         mveB/T0Wgw47Q==
Subject: Re: [PATCH RFC 1/2] x86/boot: Introduce the setup_header2
To:     Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
 <20190524095504.12894-2-daniel.kiper@oracle.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <95fd235b-b4e5-c547-3625-b23ef66c5d4f@zytor.com>
Date:   Thu, 6 Jun 2019 15:06:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524095504.12894-2-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 2:55 AM, Daniel Kiper wrote:
> Due to limited space left in the setup header it was decided to
> introduce the setup_header2. Its role is to communicate Linux kernel
> supported features to the boot loader. Starting from now this is the
> primary way to communicate things to the boot loader.
> 
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> I know that setup_header2 is not the best name. There were some
> alternatives proposed like setup_header_extra, setup_header_addendum,
> setup_header_more, ext_setup_header, extended_setup_header, extended_header
> and extended_setup. Sadly, I am not happy with any of them. So,
> leaving setup_header2 as is but still looking for better name.
> Probably shorter == better...

I would say kernel_info. The relationships between the headers are analogous
to the various data sections:

	setup_header		= .data
	boot_params/setup_data	= .bss

What is missing from the above list? That's right:

	kernel_info		= .rodata

We have been (ab)using .data for things that could go into .rodata or .bss for
a long time, for lack of alternatives and -- especially early on -- intertia.
Also, the BIOS stub is responsible for creating boot_params, so it isn't
available to a BIOS-based loader (setup_data is, though.)

setup_header is permanently limited to 144 bytes due to the reach of the
2-byte jump field, which doubles as a length field for the structure, combined
with the size of the "hole" in struct boot_params that a protected-mode loader
or the BIOS stub has to copy it into. It is currently 119 bytes long, which
leaves us with 25 very precious bytes. This isn't something that can be fixed
without revising the boot protocol entirely, breaking backwards compatibility.

boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
by adding setup_data entries. It cannot be used to communicate properties of
the kernel image, because it is .bss and has no image-provided content.

kernel_info solves this by providing an extensible place for information about
the kernel image. It is readonly, because the kernel cannot rely on a
bootloader copying its contents anywhere, but that is OK; if it becomes
necessary it can still contain data items that an enabled bootloader would be
expected to copy into a setup_data chunk.

^ The above or some variant thereof may be a good thing to put both in your
patch comments as well as in the boot protocol documentation.

While we are making a change that bumps the version number anyway, there is
another change I would like to make to the boot protocol which we might as
well do at the same time. setup_data is a bit awkward to use for extremely
large data objects, both because the setup_data header has to be adjacent to
the data object, and because it has a 32-bit length field. However, it is
important that intermediate stages of the boot process have a way to identify
which chunks of memory are occupied by kernel data.

Thus I think we should introduce a uniform way to specify such indirect data.
We define a new setup_data type we can maybe call SETUP_INDIRECT; a
SETUP_INDIRECT data item would be an array of structures of the form:

struct setup_indirect {
	__u32 type;
	__u32 reserved;	/* Reserved, must be set to zero */
	__u64 len;
	__u64 addr;
};

... where type is itself simply a SETUP_* type -- although we probably don't
want to let it be SETUP_INDIRECT itself since making it a tree structure could
require a lot of stack space in something that needs to parse it, and stack
space can be limited in boot contexts.

This would be particularly useful for having SETUP_INITRAMFS, if it becomes
desirable to allow the kernel to parse a non-contiguous set of memory regions
for the initramfs.

It might be a good idea to immediately start out struct kernel_info with
either a high mark or a bitmask of SETUP_* types that the kernel supports. A
bitmask would be more flexible, but would need provisions to be grown in the
future.

Which leads me to yet another thought.

We probably want to make the contents of kernel_info a bit more structured to
allow for content that may need to be extended in the future, or is inherently
variable length (like strings.)

This would lend itself to a structure such as:

	- Magic number
	- Length of total structure

... followed by a list of data chunks, each prefixed by a length field. The
first data chunk would be the main (root) structure; other data structures are
pointed to from the root structure using offsets from the beginning of the
structure (the magic number field.)

As an implementation detail, strings can of course be "pooled" into a single
data chunk as long as they are zero-terminated.

I have intentionally avoided specifying a type field for each data chunk;
history shows that it is generally a bad idea to have multiple ways to derive
the same information, as different implementations will do it differently,
resulting in bugs when things change.

	-hpa
