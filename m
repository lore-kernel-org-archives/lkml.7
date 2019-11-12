Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ABAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E052196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BV3xxOHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKLRPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:15:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35052 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:15:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id z6so14987974otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=BV3xxOHWbIQpFI5CB7uozaEEkwDC3lyWKTSTyPa4TC3Rd1nV/7MnrtvXeaQ1Zn/abG
         nhzwgNg+HMP/zc7thH3+NozpyQbz1ePQ/ASz5y+YgICE0CRqSZzdHbEDliWn//CnYMRu
         vHRCY+Y8CVfx8lHiYzbdQMlPFcMr0aCT+stJMsIb3zLNuQGMY/pTwW26u1A1i3C9XOW+
         nw+Nq64NnYGla6dF2P9v2y4kMFTef25LsJwSzbFUjnSsxuStNJXwc4PC154fjf3VfdPF
         5LsksQleIaBa3iFOcbqYVbhweUIDtdGWopLOAv0G/rosJkOeTyOR/j9fGyVuxi7E4yrJ
         BsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVzIXHrO764GfG4Qiqm8/IBriT7RsdH75hTLmp9BmRA=;
        b=qb5UuX7mk5vq4D+DRBVZarmnJr+Ic3YU9eUH0ZOvyYCeSJr7rDcTWGeyp2S+6YG7vW
         OWqJ015zq2L+KdVKNLd3GIduS8O0LTpJbvurDFejoya+enkwU4C3SuO4zFmJ+NIe05o9
         t/aNhhfCTXBlSIr5lSczTIIHPLs3c59IGMOxHRuSJ1zFFGMsMoN1+7DZVvnbWqVc1cNf
         V8Mn3fLdnlBSvBpENIODlXpy5HdvyTv7qyZM6gX3dFXkDnGf8uOkzuJW+LRitrGJSUZg
         JvYxsKCz7Htpk7oRdd1DVG6+snQ3npCnLR/Qcpqyb9HS61EmDYBeDBSPTITOO2VzFPEd
         Fetg==
X-Gm-Message-State: APjAAAXLlXSF7OjV6xJ7l46WI07n29l/mSdqJBSLiOXxzl60digUx9zf
        dLBf8Vl73seG2GiGoie0JTU5vqeDi4UWltDZZu7faQ==
X-Google-Smtp-Source: APXvYqxBWRXUbhgUeJAvflllA99xOkq97GoI6xicPLh5pWfFwhtbLObGxHb1Ub62atqTxWhI8Bsq8hQNoxBqMIRsSJw=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4555105oti.207.1573578928797;
 Tue, 12 Nov 2019 09:15:28 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 09:15:18 -0800
Message-ID: <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
Subject: Re: DAX filesystem support on ARMv8
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
>
> Hi All,
>
> As per Documentation/filesystems/dax.txt
>
> The DAX code does not work correctly on architectures which have virtually
> mapped caches such as ARM, MIPS and SPARC.
>
> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ?

The concern is VIVT caches since the kernel will want to flush pmem
addresses with different virtual addresses than what userspace is
using. As far as I know, ARMv8 has VIPT caches, so should not have an
issue. Willy initially wrote those restrictions, but I am assuming
that the concern was managing the caches in the presence of virtual
aliases.
