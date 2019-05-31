Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2659C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6628B26B1D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X441yaSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEaQI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:08:59 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42377 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:08:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id z11so7026959vsq.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilrYlpnPo3yjlxe8uSzw+1HTXqlZ/4Yqy8YgIni0bQY=;
        b=X441yaSgplyDEhQF0DaRMNATgjh501Un3nE4VB+9rZ/67dPUBcK19GuZxN9hEOzyAe
         VAzkTU7wxoPOc2fee9hZMfZ3X2raTcb4bbHhNSb067fQNPdJkI7Afw6K4+aEyiOJxxS+
         9cQQuIjWjPzR8xOzg2eUyiIPyP4Hv677/XukuoWN2eN3XUoflH0Ka0Rmafyhs+odWiri
         JWULW4MwlIfRzLiRfVZiNp96FoC2icaMVkUzzSK9WIUkOqRNSCxuwyvt4h6N76XvZLg5
         ZHtL9p05T60/mFCduF8ld2zDd3FFdJKAzAJg2A4Y9c0zEWZwhgvVBdLZTJPQarFbP+vL
         9c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilrYlpnPo3yjlxe8uSzw+1HTXqlZ/4Yqy8YgIni0bQY=;
        b=LG6jqkwtM3Vtim54QY5vSK0D9k3yKi/coua14+AeW3ytgScqHso/cqKfI11vxauIBW
         SNgTo4IePZW5Y3fTLf3ouj1W36a9CspvB4gSkUBwgIHn0fC+bKlDTVtCq5f0DOygyNY2
         t/3max46cEb/nqrrIedV31jw+lCHPi18ilHtDzHR9+AzIBnQ+sufS2HB4aSqfHtCDIXx
         ok84/4NuMgW59BtCPowuidCC/pnibdFqntSaCaw1by8/YxJvbk1IuiCoRrK6L4j17OtD
         hoDyGL3sG6rMfu45l+SPzUVCSYPa6xSuKgLTNW2y9zP9lUmVOxIEQvsmwAOdvJxTs5Dx
         S/jg==
X-Gm-Message-State: APjAAAUPeC8ZR4UbFuqP9lrCHnPH9LaFXFnm00Jjlbqxp4kZyPelToyl
        eE91ucO+0paHWCgFJmDzlFv/qUlKulVDrbPrKJ1nWzwW
X-Google-Smtp-Source: APXvYqzU5oEIXv9AUw/zKQ0bHWu9hWQTgmFHxHyDtn4j8KvVowUFgs2IV0mI3maVvDhEgrsyBemeN1wpfROninVY0kU=
X-Received: by 2002:a67:b147:: with SMTP id z7mr5445254vsl.228.1559318937876;
 Fri, 31 May 2019 09:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190524194930.GA13219@ogabbay-VM>
In-Reply-To: <20190524194930.GA13219@ogabbay-VM>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 31 May 2019 19:08:31 +0300
Message-ID: <CAFCwf12PN29ax1zK2sV3NjzR7N76CvJ3jN51xXqr8y9vHMBatw@mail.gmail.com>
Subject: Re: [git pull v2] habanalabs fixes for 5.2-rc2/3
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:49 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hi Greg,
>
> This is the pull request containing fixes for 5.2-rc2/3. It is now
> correctly rebased on your char-misc-linux branch.
>
> It supersedes the pull request from 12/5, so you can discard that pull
> request, as I see you didn't merge it anyway.
>
> It contains 3 fixes and 1 change to a new IOCTL that was introduced to
> kernel 5.2 in the previous pull requests.
>
> See the tag comment for more details.
>
> Thanks,
> Oded
>
Hi Greg,
Pinging you in case this got lost in the mail.

Thanks,
Oded
