Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE1D208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6MDB+JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395083AbfITHfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:35:00 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:35291 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395072AbfITHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:35:00 -0400
Received: by mail-io1-f45.google.com with SMTP id q10so14066163iop.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/pRI5s675ZgE8sFIt/EXn7EthhsMe/0n96FtZO8bGpc=;
        b=H6MDB+JAVE/8h9k7Krkpq2DTauDKqModIUqtF7aGhaD0XUzN7aNOvrVFf4jT+HXg+I
         LoubKetlmnBlZaF3rzuwZNIVOzQ/93smeZcVfXBWdaA+OrdH/qwWjaKClvirMtISsdQL
         BnM5T521mbZ9ION/zJyq28yicuWrHxAP782KtXG5soF6HelO69ikbVqaWkz8nLLsulkQ
         YArU/+QRV5WWHyrbJ0BhNstKAwltVXLQVVpCzVpAyvdMM1/lbQSGatudaeS0ynaounhw
         HFaDVaNJjQ4rQCbcxVJhP7lRxFfSXO7jUaWOHjCm2eAaDfHDfpN69T7+3HJ+zFmtwWU2
         tQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/pRI5s675ZgE8sFIt/EXn7EthhsMe/0n96FtZO8bGpc=;
        b=MlfikYbu1MxGkB+yCpKu/ZRKHTaiEZiTY27QjZhROxad+vwjj73tP4jwJI00wltI/t
         wQD7z6xv8e2h2mQ/xTsjQo+xGmLunQdTNlH9MMxt0eyFkFZ+NymjK0XIoD+fIwKYpGM3
         F19Z+ltPwbifaoZ8zt3B2+1OSSDkLiJFq/d5ufT2gvQ/230PEIM0NhKEwCKbNjg0Vz00
         OIcJObUv+6/PfgqcwVaxHzY37eo7uwCnTqT5U3ldo4jQMIchYMxcz2KUjoB/xmpDt+1J
         oAHZfYjxGfQoYDuFZ1X9RjMYuRNfYnZBcqajlEMlqOxNFklrpV+q/WLT4DuNeMr5LO7O
         jaKg==
X-Gm-Message-State: APjAAAVOh9vLRjLPde5Y5Nazj4Lc2pjWpQjgoYmj56SDuZmHw8tbbFSZ
        Rkg7dS0YAKgfZGUlujtfoGnZ1zPNKy3k+HnSuu2Q63IM9is=
X-Google-Smtp-Source: APXvYqygWq58S7DlQ8StJSAbiwxfyGZ3DOIeoxrjLe8CWMSlC8r5q+d5YbsGtTrOZlzxQYe3FAz2aLMkOjlYPrtGRgw=
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr5525140iof.272.1568964897490;
 Fri, 20 Sep 2019 00:34:57 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 20 Sep 2019 02:34:46 -0500
Message-ID: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
Subject: checkpatch warnings in sched.h
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any hints to get rid of the noisy warnings in sched.h that make it
hard to spot real warnings:

/include/linux/sched.h:609:43: error: bad integer constant expression
/include/linux/sched.h:609:73: error: invalid named zero-width bitfield `value'

I noticed mention of this on lkml but didn't see any suggested
solution to this distracting warning

-- 
Thanks,

Steve
