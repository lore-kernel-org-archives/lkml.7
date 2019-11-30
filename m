Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442FAC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FA520833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU4hgwDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK3SOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:14:34 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39677 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3SOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:14:33 -0500
Received: by mail-wm1-f45.google.com with SMTP id s14so11564596wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6+mR07YWSD8YHD63SXerr51OwE401KJt9PgwZU3IojU=;
        b=kU4hgwDlls7/sj59V/a4ooQxccuqAycjozkTxxBtHg1WUvJQ+JUZNVOuxBdwuDtvZU
         m49Q7pdH6wgtdHaYErQ/VYAqDbqxBuHkAMu/2QTw6ZNjXIBN5n77b7NPavyWo0w3i8Km
         464HCNt0KbN5V4Zjiv+ZgGQUq4f9C2hpuxd03AXtw/se4tfssSyUalX1AgpelXGcOs5L
         pEKzaEI0VX3JOUpYBjkROSg806fCxH/0jBj1d6JIQcTvQHkThe/IkfzQL2FR8hQGtU77
         9p+wDD2tsGJLgcaDnKGnVFLQSHOdF0aoY5UyqY8ARsx0ezn4PjHQIFjuLRzpdPk1hPwA
         PSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6+mR07YWSD8YHD63SXerr51OwE401KJt9PgwZU3IojU=;
        b=W2n32NQpGPs+aqw/oEAmrkw1nvnIsWoqXleJxgtmW2/hlDTimVjM1E20Cno80awaP9
         ymGPFsOOvGNL8s5N7Cwh3NOZgetXxVQ4vicvv1uXkcMmZkvSBioSI8Do/C81sg1TZsz5
         vxjpwQDr3XtdfMYC4mhovoSF61bQLu2xdOSuAm91D4eAJ+T+Fr2q+Ts4T1+1dUcaUmoF
         LwjeKz9JOG79jd7SdDi0DrhJU9LXeVNPKXFyzglq9MPhhbxUnsLl5w/k2ZIzOpcCqEVT
         znOwtxK83ig0QX7nGhJ2/efvR7cOb1pjHaUSYeIBNoSNm33JcZnv/z2dDdC8q/XbQJ/A
         H77A==
X-Gm-Message-State: APjAAAWhBwwyANVXAvelR+KLyXeEoEfYYR/slZur1hRQ/WJlHpeK5X6a
        JrNBdV7hINy7tptoI77rXwwojnnD
X-Google-Smtp-Source: APXvYqy0TZmid9AtBF/qO/FZqLXORQgqDFY38++CJLyoqulQs88ja6DDG8Ikbk5VPWQk9YXKjG1W+Q==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr22016138wmb.153.1575137671399;
        Sat, 30 Nov 2019 10:14:31 -0800 (PST)
Received: from gentoo-tp.home ([2a02:908:1086:7e00:b6c5:9957:10c9:5b67])
        by smtp.gmail.com with ESMTPSA id f2sm10368278wmh.46.2019.11.30.10.14.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 10:14:30 -0800 (PST)
Date:   Sat, 30 Nov 2019 19:15:48 +0100
From:   Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Regression in squashfs mount option handling in v5.4
Message-ID: <20191130181548.GA28459@gentoo-tp.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on an embedded project which uses 'rauc' as an updater. rauc mounts
a squashfs image using

  mount -t squashfs -o ro,loop,sizelimit=xxx squashfs.img /mnt

On my system mount is busybox, and busybox does not know the sizelimit
parameter, so it simply passes it on to the mount syscall. The syscall
arguments end up being:

  mount("/dev/loop0", "dir", "squashfs", MS_RDONLY|MS_SILENT, "sizelimit=xxx")

Until kernel 5.4 this worked, since 5.4 this returns EINVAL and dmesg contains
the line "squashfs: Unknown parameter 'sizelimit'". I believe this has to do
with the conversion of squashfs to the new mount api. 

This is an unfortunate regression, and it does not seem like this can be simply
reverted. What is the suggested course of action?

Please cc me on replies, I'm not subscribed to the list.

Thanks,
Jeremi
