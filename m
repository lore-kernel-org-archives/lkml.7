Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D3A22500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rV8UhWMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfI3Uq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:46:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53663 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbfI3Uq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:46:26 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8UHInd2638716
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 30 Sep 2019 10:18:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8UHInd2638716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569863931;
        bh=JwI2GQe8WUKNFB035wz5DGW06YwngGprr3IkNYS8u5s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rV8UhWMixJHKEtVPswnXhC5wV2tSbK7P8eCTnYvcEq41sjRTGe8jMaEPr7PEIU4JV
         2RIJkJSEzJXzQNj1RLVLOA0ZI4R5mAcHFC2q+hxdPfyTvAtjnSgCwQyVVH11R9fmWP
         shlcPmdLSUojAoshDzRB4O7RHsR36RymdOPBnkALI022g/sMM/4IUxgnufAeT9ML75
         U/hgjswu3UA5WoUIf/T5uc/MF0rW0bh5sV+fQqcfTV9HANRijbN9ARnqO+DS4PFfaR
         OSnyYlaGTZ+kb3fLEz4IFMs1dQMDy5DWNQXo76yPDDy4dBwr3/v6Ppf9pjuX2rxVrl
         J+B0X9vBw70xw==
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-2-daniel.kiper@oracle.com>
 <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
 <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c9eb5a39-ced5-b35d-616d-6ffbe15c1396@zytor.com>
Date:   Mon, 30 Sep 2019 10:18:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-30 08:01, Daniel Kiper wrote:
> 
> OK.
> 
>> field for the entire .kernel_info section, thus ensuring it is a
>> single self-contained blob.
> 
> .rodata.kernel_info contains its total size immediately behind the
> "InfO" header. Do you suggest that we should add the size of
> .rodata.kernel_info into setup_header too?
> 

No, what I want is a chunked architecture for kernel_info.

That is:

/* Common chunk header */
struct kernel_info_header {
	uint32_t magic;
	uint32_t len;
};

/* Top-level chunk, always first */
#define KERNEL_INFO_MAGIC 0x45fdbe4f

struct kernel_info {
	struct kernel_info_header hdr;
	uint32_t total_size;		/* Total size of all chunks */

	/* Various fixed-sized data objects, OR offsets to other chunks */
};

Also "InfO" is a pretty hideous magic. In general, all-ASCII magics have much
higher risk of collision than *RANDOM* binary numbers. However, for a chunked
architecture they do have the advantage that they can be used also as a human
name or file name for the chunk, e.,g. in sysfs, so maybe something like
"LnuX" or even "LToP" for the top-level chunk might make sense.

How does that sound?

	-hpa

