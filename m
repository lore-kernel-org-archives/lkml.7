Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B480C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1495220803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CA8U+ILS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLCRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:42:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34619 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:41:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so2212795pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPNclA55GeMuTPy00O4xA3XNidBB0rleD9eOny3IQXU=;
        b=CA8U+ILSVCqpsw6oVcTIiykcDXOPtAQZ3dRCBFCZF1Nnq9ZRybkNiuadJE3k6L38nk
         1nM6dfAtI1nmuq17a2w3pQeYTJcbN+0E7hZQXNu1BmYtv22ZIo+H6t8xILsvT5l3PK3F
         jKAh96PdF5kuA3LEMjN+Mi1PK/05bdRSWUicAd9PMzhTT1G7ELE6IpqgsinlpfSopyS/
         lODY3D32qAbzArZ+QI45bVCSRWDjJAaFswGXvQ/spe0FY5bCVUlTftGsJzDCsvmGUaqy
         wBCVGR89Awy9K5FZunIUztSkOLIa0VchzzRL68mjE+rANibb5Yi+gTiKo9Ce0FEKX68U
         pmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPNclA55GeMuTPy00O4xA3XNidBB0rleD9eOny3IQXU=;
        b=XihI17mQd96BxWwB7x7X/19FihAg8ZDz+7YMZ34A0QQyTx0mjoibEaG2P+leZ5pwb5
         TTPfIn961Qfr8zhTm1aGJsds565r5xiLxujgQoVRUOno7Z7g5/k/w/6ert0Osklajk2f
         7KHP7CJ/zeidPhqP90SYDqkixA9rq0yTpOcXQAmcoujR1c+3Xg98xRuM4RsTYYPGPr7E
         mFZy8zNAhW2gV3oeZbCLdjjUSMrdQIth7EbvdBRdbzrnCg//Jp8oNfNG5LMKtYft1Vk9
         9/+b6AIYG9MZw+nU9PuRYv2Okx8zz40TAOc3pPsrQHqf7chujapKuKVC/W8f+SbPx26e
         zxzg==
X-Gm-Message-State: APjAAAWFy2L+NFMDg84TEj6zBxl40KKXg1u5KvYxEOP1DnPAFMWl+G83
        /6Vy1mP5rNoHnPEmm3K+kU+PvU1d6l6dJS8xCrvdcA==
X-Google-Smtp-Source: APXvYqyLfrzqw76FsSf7xNdSx42vZjlHk3EqzEY2B6hdnMDa1YuE2bPl3G/so4GSGjfHNmL5z7UDa/RdVqlVulsRkzU=
X-Received: by 2002:a62:174b:: with SMTP id 72mr6112264pfx.185.1575394918652;
 Tue, 03 Dec 2019 09:41:58 -0800 (PST)
MIME-Version: 1.0
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com> <1575361141-6806-6-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575361141-6806-6-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 09:41:47 -0800
Message-ID: <CAFd5g456ZK-zZw_E2O1MOC2-vjwQ8Rpm=tuNMscks_mcOsdwxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: Rename 'kunitconfig' to '.kunitconfig'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 12:19 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit renames 'kunitconfig' to '.kunitconfig' so that it can be
> automatically ignored by git and do not disturb people who want to type
> 'kernel/' by pressing only the 'k' and then 'tab' key.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
