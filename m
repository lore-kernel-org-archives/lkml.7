Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FDFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92572080A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0Cp49iN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAFVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:45:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46994 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:45:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so50031368ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjQqjrgkh7UnNQJ1G1FfRv0Qnrcc+UBzR3ffHuWmJLo=;
        b=T0Cp49iNhBPtry9RRB9H+4/H9Cnci8jBAdb1agffxxbBZu6dSlRujUOlO6q/7+po8t
         NukgfrM75WAPZX1AMqK16k1GbqFYWxukeGtta3bKoaYbWTZfheDRoEVQpqgjbqrwy3vD
         qu9KIfq92QbOMNPQ6wY4GF+gKyepaOsnp5LmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjQqjrgkh7UnNQJ1G1FfRv0Qnrcc+UBzR3ffHuWmJLo=;
        b=dNY3+yNKyhIfGlL7DznVLJPBgtAkzuEAYXYOIf6lQjQBeH+AHzUpVCEz3SmFEsFSnz
         ZbmqcAB8aKtqgT4GBULoONtV+4+kmmMHnHSw1k310H+l9mfQrTbD1vum0fJeOlVvqeBP
         yut/KDluqyGXsnKrCvJsxb7tCGGCUWghAsqkRzqLAMzbJl3evRocU/kAI3Cfau3OmvrP
         zUfzclZ5Y/QZsTekHodNRgIB/1G6JnDIJmCceyouyjTqfyOBmDGoo0lcrSXMDLwhX+m+
         aRVEI5Xj3FGmirdmnfHEfRKFMQma0sZhiiuKipJNFSiRiMxd2XAjOYsdihQMRQ0L01Ut
         zmSw==
X-Gm-Message-State: APjAAAW8Fqb2FH0CpRSc+AJxku3XrMgzYA6DcE8ORoaAMToH16iFnhAw
        yFaT+adjeSeNTmW6CSyj45ZRhSxQaLg=
X-Google-Smtp-Source: APXvYqzB1Zh47mpxTXwHKAda2OP4UKBmvZA2TTDuGZkzKbJVJOX00Pk87q+pryGBBlZ2GUp2Z4NUUw==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr62132570ljg.223.1578347118800;
        Mon, 06 Jan 2020 13:45:18 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h24sm29694295ljc.84.2020.01.06.13.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 13:45:18 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u1so52472018ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:45:17 -0800 (PST)
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr60097737ljk.15.1578347117398;
 Mon, 06 Jan 2020 13:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20200106172746.19803-1-georgi.djakov@linaro.org>
In-Reply-To: <20200106172746.19803-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 Jan 2020 13:44:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft60FwXEVxS5DohqBaQTFOfCZ7co3b3KEQyongGNB==E0Q@mail.gmail.com>
Message-ID: <CAE=gft60FwXEVxS5DohqBaQTFOfCZ7co3b3KEQyongGNB==E0Q@mail.gmail.com>
Subject: Re: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 9:27 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
