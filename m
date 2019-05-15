Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909C6206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfEOMhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:37:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41270 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:37:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id g190so1333398qkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQrskfuhLr6R1EA1Dc/80hFPCJtQv2oLo45DlVALQvU=;
        b=KKN7B/j6eS5uhUE/cUkI2beka5WbnwFJXXafxfE797eOuP1Lt0cDIgFwa+VV2j3k48
         u/IcFDYqsHuVbUYhiZ6BbpyCU/cyyAZ6LT+w6CG3wmCBL2RSObAGTOfdIKBsWBgJsErb
         aUNbfjixmcyMhrUfX3gloW+sNb+AAzOZh40aKRkBel7mxXhuaHSxSTDshfLjwFonuvyf
         blKSA2GJ83xuabKbXisW93e9qf1+rdq2sN52UixwHXwPej4MSCd7Vx0Qyq6tvnRmc/q7
         AtQ0b3AWiehi+OvxK1Mn4ofRUWtGQBH1mX9eyvpg088C+JejTdodZDPlS3faPNuQAKSL
         mwcw==
X-Gm-Message-State: APjAAAW9mQ/S/UG013DBZCWiK0pVZW8Gsz++csTyshG3dvi4cU4+ew9f
        Xl/JyLY9KEC2NHtIFKk+Qwviiej69M9JYa5sWFA=
X-Google-Smtp-Source: APXvYqw71YPazQZnZvv7kJ3Z1HtYzgIR2jworWmBNo2MCYrdqzyxIAB0wy0Vr3KiBJyDTknSNP5y/f3KJi3TdezVuK0=
X-Received: by 2002:a37:5c81:: with SMTP id q123mr24106184qkb.29.1557923858194;
 Wed, 15 May 2019 05:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org>
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 14:37:21 +0200
Message-ID: <CAK8P3a3ma-kAYSNP=wxXiF0ZWUJmH-UrysdiJ6kM67EVrEiGdg@mail.gmail.com>
Subject: Re: [PATCH 00/18] net: introduce Qualcomm IPA driver
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>
> A version of this code was posted in November 2018 as an RFC.
>   https://lore.kernel.org/lkml/20181107003250.5832-1-elder@linaro.org/
> Fixes addressing all feedback received have been implemented.  It
> has undergone considerable further rework since that time, and
> most of the "future work" described then has now been completed.

I think this has turned out really well now.  I've gone through the patches
today and not found any real show-stoppers, but replied with a couple of
minor things I noticed.

I think it's probably worth rearranging the rx and tx code to avoid
the spinlocks, which would be the main optimization I can still
think of to reduce the coherency traffic.

       Arnd
