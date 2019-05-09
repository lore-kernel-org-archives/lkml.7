Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E03C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0C020989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzMt1wUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEIMwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:52:16 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39119 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEIMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:52:16 -0400
Received: by mail-wm1-f52.google.com with SMTP id n25so3036142wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=b4fXl2ezED9qXFMqCDwWApdN4IUYFG9hSmFwQQBnSoQ=;
        b=XzMt1wUvh0NvWczJNujvXCGGG6RKv71yEgdnjzsx3fbDa7s3xQWZTv9ECztTEIE6eD
         x/ma8rtwiosPurOgxrkJTrIjHO8I/In+UXrU+xsV3qJzshLDVe12p42VEMiehQvetNam
         eWp1D7T+yUr2j8YjvG+pxxcsWv4KO5+3MyNJuVItX8oe4dhrAb2BdJTkQnAjElOahuyo
         ltlS046ny3lrooe4Pu7kSPFCCjKUzCm/M14JFjDoXhnQRZOC+74kuT+xwoeHDMIrKKZ1
         HH2SP5hYW99ezDbWOf8Ivm6+7XhDgi+ata4MRVpRopzfLIWK3JV4rB/s31AQH2doWCZS
         Qa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=b4fXl2ezED9qXFMqCDwWApdN4IUYFG9hSmFwQQBnSoQ=;
        b=YR2UDTocOf9o/QjC1kBEGGzxD2XAXw0xkuri0NZlnE3SvKH7SWe7APTl/nunVqArRt
         nEBj6cd4ML/v+AnGkIib5vdR776MtcEIVBXh3s5jsV58L8GWPdWGaQbvLtfJ8KXqPdhT
         R5sRrHYAWrjRESsj4J/6BSbA7itp1fkltTumV7ImzJdtJOkl3LrJK7WxlvnKGjNV7yMR
         ufLUd53GdkHpkYJwXCijsQAYg5UBXHK5OFNkpg2SWGMZNoizON0emXuCecznrNWQtD26
         mQRNtKoQmDYSv1agx1OTOlV4AlTAphHcT8aa1xKHnvxRJ8nmyzbkd3ZWIL8DWjF8Rvit
         EObg==
X-Gm-Message-State: APjAAAVBXzdPVimYouWDdDrL80dvdJFD0OkwnvUT+CRuf56+8GAP+5JT
        mPFopQTKNpLr77a87Ni3v55Lb81a
X-Google-Smtp-Source: APXvYqyphwohfPBhrOsbKY0vSjwguNo8F1+/Ufc0s7VB5oD4gzhDzxtEa5Swm/S9r9I2v5OgmaofuA==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr2707925wmf.116.1557406334008;
        Thu, 09 May 2019 05:52:14 -0700 (PDT)
Received: from [10.0.20.234] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id a184sm3165981wmh.36.2019.05.09.05.52.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:52:12 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.01 is released
Message-ID: <be234111-748e-5bde-56eb-f21a4d16e23a@gmail.com>
Date:   Thu, 9 May 2019 14:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.01 - man pages for Linux

This release resulted from patches, bug reports, reviews, and comments
from just over 20 people, with just over 70 commits making changes
to around 40 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.01

A short summary of the release is blogged at:
http://linux-man-pages.blogspot.com/2019/05/man-pages-501-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.


Cheers,

Michael

==================== Changes in man-pages-5.01 ====================

Released: 2019-05-09, Munich


Newly documented interfaces in existing pages
---------------------------------------------

tsearch.3
    Florian Weimer  [Michael Kerrisk]
        Document the twalk_r() function added in glibc 2.30


Changes to individual pages
---------------------------

bpf.2
    Michael Kerrisk
        Update kernel version info for JIT compiler

clone.2
    Michael Kerrisk  [Jakub Nowak]
        CLONE_CHILD_SETTID has effect before clone() returns *in the child*
            CLONE_CHILD_SETTID may not have had effect by the time clone()
            returns in the parent, which could be relevant if the
            CLONE_VM flag is employed. The relevant kernel code is in
            schedule_tail(), which is called in ret_from_fork()
            in the child.

            See https://bugzilla.kernel.org/show_bug.cgi?id=203105

execve.2
    Michael Kerrisk
        Note that stack+environ size is also limited to 3/4 of _STK_LIM
            In fs/exec.c::prepare_arg_pages(), we have:

                    limit = _STK_LIM / 4 * 3;
                    limit = min(limit, bprm->rlim_stack.rlim_cur / 4);



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
