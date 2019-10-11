Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8706EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AED2218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJKXmK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:42:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:42:09 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1iJ4Xw-0001Z8-2O
        for linux-kernel@vger.kernel.org; Fri, 11 Oct 2019 23:42:08 +0000
Received: by mail-wm1-f69.google.com with SMTP id z205so4819120wmb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 16:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=92pEGUqS/S/KSPp9bTMahlMDEufG25vdMFkXaZGplCE=;
        b=K/DrItQaMOX2RFmFLHzZYT7AK6QVu89HRVcwgvXVyF0+AP3Y9gyfhYNHQ2Qi1YTGu3
         KF4bqqP0suxTXuPjhGJYhSykJ4GzGU/TOUGYuQulprfkTm3rn0gXKFoMHSyfPO+b5IvL
         HG86yq17b0sSdn7u4u9C5Zf64cUM/wfaK2mZ7HrOGsm3ZrG2r6txsMWU4VQT268G/Gg+
         nsbtreO4e8vos328dYQaoyaqC1oxviIZifImRTfvmsZ9FAWSKyWZaj42/KxNBfLTpZRn
         UyVvsf93UFEZCclOdtISG7lvW8O2XEbQuiCPGaTzr0EG4ZbSeONTh9Ig0DU8WSE6+6yh
         mYxw==
X-Gm-Message-State: APjAAAUqB2NXTero9WVpX7n9taubrMypBbZaAmSMQekqodnA4BZtzuLk
        moVOZQ0LHMHBWFXW3oS9xJWenAGbzAH7r4Afr/vvM0bixCe0OW+ue7Lgnr8OLldFMPE+aOmR7ZF
        iNkgj5SvPdsh6sXnxftdoPZ9vNVslU9JpWnC0r1oYJ6dsXWhvnFkmTbAUmA==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr5125923wmc.121.1570837327857;
        Fri, 11 Oct 2019 16:42:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylQm8kBOrJN1wK3uuE1r9eFdnGsE1vLFTpvB9yJbMEzLxNJu9inthxOqwtdtx/wsxR+hw/CoX8TYXgKJlpkc0=
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr5125908wmc.121.1570837327692;
 Fri, 11 Oct 2019 16:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191011223955.1435-1-gpiccoli@canonical.com> <36C2B5DF-7F21-42C6-BA77-6D86EDCB6BB3@lca.pw>
In-Reply-To: <36C2B5DF-7F21-42C6-BA77-6D86EDCB6BB3@lca.pw>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Fri, 11 Oct 2019 20:41:31 -0300
Message-ID: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages creation
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 8:36 PM Qian Cai <cai@lca.pw> wrote:
>
> Typically, kdump kernel has its own initramfs, and don’t even need to mount a rootfs, so I can’t see how sysfs/sysctl is relevant here.

Thanks for the quick response. Kdump in Ubuntu, for example, rely in
mounting the root filesystem.
Even in initrd-only approaches, we could have sysctl.conf being copied
to initramfs, and hugepages end-up getting set.

Also, I don't think the "nohugepages" is useful only for kdump - I
found odd we cannot prevent the creation of hugepages at all when
using sysfs writes.

Cheers,


Guilherme
