Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE170C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EB5218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz16v9Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfB1T1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:27:54 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:38870 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfB1T1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:27:52 -0500
Received: by mail-it1-f177.google.com with SMTP id l66so17512635itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nycqOmeNUKBjRiU6n5X5vbwpiEK+Qw7NbSaLdjcSOjw=;
        b=Tz16v9JqT0NV7pFmwB5BVrQ9v3DR28esAH/XtV/EgA+xCfa6n85HWWNYOQrdZ6tIb4
         37XwjDDwes1e0dXWLv9J9nD4nppxuG5xczjn3syRAoajMM6rUYSiaPyrbiBp/qZtQUt+
         dTyRPl5bdtM+5qyxROL218KCNNMBNcqCtKnKHQpArBcdDgT6bRZLQFp+aD0MOup+kjTr
         FjhjJ2BeKEmXsVDJ6sI6vSOF6L2K6wd6ExnxgR38zTPHxpHbbyqOh/uWTRB1HQnKrpiD
         FQYsn4y1SWhMRRYRjr5jQ4mfgcQR6E9rphZBMNDcabZkMAFXnPdmwUgcC6U5npU28sif
         HFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nycqOmeNUKBjRiU6n5X5vbwpiEK+Qw7NbSaLdjcSOjw=;
        b=gFWaUKFeHq+AjvV7zyMzj56PFuvwBbheDJNNxeXAjQS2UvYfHwOf75F24BqT3C8Qmw
         NPImGBT2C4WJy47/qgSgsr6YMEhGte8tcPP0KZVme2jhjk1LAzB1kW1b3EpM+QbJJYaK
         iCimjP5Qj0mXGAxBwj6wRCCQVI1VgGelVbSy/l6cTnzuEfmXmj8SJe1otzlDOenYgTny
         TOEKDLMlb8BGFjbct5N2EXG63q8uJDGxVFEHf+AlZDFPyRTlMBuYBlKkaK+rge1aGJu9
         x3pdd6uixmQQq+4gBj5RhkTf6Q7DVQ2AMyPfzPkCJirjO0bsPat9DTNY6CglxwCiqQnZ
         w7/g==
X-Gm-Message-State: APjAAAWhZyHn39GrkGwoafH9YTATdffhSrCSLDFwiuqKPCYpdN4btZyr
        MRoRT+YO8T5HJUBWd0yuk0BRVsu+MRqAFk4fqccNJw==
X-Google-Smtp-Source: APXvYqxw5nmve0KJdx4dlef+HXzGf4LlS+/GniszUgmHCZHT0Wco1WM9lezjeLvlfp3sI7PBXwTSBOW8BMqEXFWz4BQ=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr486396jaa.26.1551382070236;
 Thu, 28 Feb 2019 11:27:50 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 28 Feb 2019 11:27:38 -0800
Message-ID: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
Subject: Allowing mapping supplemental groups in user namespace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Currently, unless caller has CAP_SETGID in parent namespace, we can
only map effective group id in the new user namespace. Would it be
possible to relax this rule to also allow mapping of supplemental
groups (1:1) of the caller?

Thanks.

-- 
Dmitry
