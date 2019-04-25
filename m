Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407BDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C99B20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="a9v3hlFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDYXWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:22:08 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35657 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDYXWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:22:08 -0400
Received: by mail-wr1-f53.google.com with SMTP id f7so1735229wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WAOZ/hI+QOoSDtWHt2CtP+CZHTmG9M4aMc7OORcdh48=;
        b=a9v3hlFbGjFVCodShnOzXs+6M866LI/d7G5d0f23vSx/Db3Fm/QcIzYw2Bd4+VI+Ez
         CT+apsKKkNUgI8ZN6E6Idjgy/pK15B6DnWUUoSuiajgHoBl3S7wpygXhDFnA/yrR1A3I
         u6Two01X7Rq9aKSk0zGT2EDpvwF1ycyTh76hhnQOjQ4JI6osmsDK5M6sZCcDQUd5rl5v
         4mGalxMkVgr/kf9Q5JpkpdGEeTjQPRCWAZPV1X1p6PMLvYcavCR1SFY4WtJh1+j4raG+
         sZx5L3E6q9k/liJsMKZC9v8pO51spBRKyRf6QSXb1WI6S2zQsvnt2EDuIBiuS85Q5ip5
         0F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WAOZ/hI+QOoSDtWHt2CtP+CZHTmG9M4aMc7OORcdh48=;
        b=p0jYHI+7cahjCgoiEU2NJnx07oSIPvO5woLb870w/WVx4Q5feuhflbHEZrIGOu+FQ4
         c5fmMthzsB7bbmoKa+oQan8uzt/mkpZsPwyKrks4PvXcX4qADqy7tYmlmO2rAQB0IcLh
         2lw/9BphiD8rNpYYNuG8MCQYUF4vZ24UbkqiCA7i/hU1dHmz3LW9a2kA6vrgK+Ou/RBM
         d50LOM4AXtUE4wRc9gbI8Gn04VyPlKbyDGehUmCGSXLNuz/Q6NfR2Kg0NnZjd7sS/+iE
         CKUj3axUqS2k+V5DDk7dAjxLmiDeonj5nTDbfNMrgoox9GArCvZ31QZhjSnNVIOUC7fE
         170g==
X-Gm-Message-State: APjAAAW9kXoESToUK4qC8qoHGGBpXXP9ytJhrfSP2PyLMylkWn/CyOEd
        0cjQnx83W3+Q0aENU4ZzMtjtLQme3ryzfXiFwWGQYA==
X-Google-Smtp-Source: APXvYqzHOc6mq/quYq0TipKf6BKllPmPtu+plNwxN11e7yhYZNf4BrotkUQBRwHWdfdScd4gburtHAN0BtDmsjOYNSY=
X-Received: by 2002:adf:9ccb:: with SMTP id h11mr1389916wre.257.1556234526535;
 Thu, 25 Apr 2019 16:22:06 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 26 Apr 2019 07:21:55 +0800
Message-ID: <CAFRkauCRwV-MbuVLvvjoK16_y4XBP5QFTByy8LoGP7EQFht0jw@mail.gmail.com>
Subject: regulator: Several commits are disappear in regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I found the commits between 2019-04-10 ~ 2019-04-17 are disappear
since linux-next 20190424:

linux-next 20190418:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/regulator?h=next-20190418

linux-next 20190424:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/regulator?h=next-20190424

I cannot find these missing commits in regulator tree now.

Regards,
Axel
