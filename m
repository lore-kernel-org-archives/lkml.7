Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19121C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DDE2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz01h9Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfIIGdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:33:19 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42934 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfIIGdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:33:19 -0400
Received: by mail-qt1-f170.google.com with SMTP id c9so14950157qth.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHc8XSw637FJ0GLoexd3QwouyWxoaR8yvfc8r73VzIY=;
        b=dz01h9KrKa2LpnJ90LevBSnoMkTz8QGQjXmp2TrzVx7uD+sEjmvh5vutqCJ3LoyLlZ
         JJYjM5I2Q0yHJLauNv6lg8zew7W5JKJs1mLJMOXPojQLUBXdC9j5/Sv3mXq39rIjY8SY
         9O/lkGfSc+JmuJN7Tf/rpLMWAGAURbG52am/8x827+c+v7FBAHnXb0k86uFeXEG3YK6p
         44k7buV8JV8hOmwC2rwyD+O3TELiYcPTJ3sqgG4WOsv4Oae142SMNoAlbT6uozPboI5e
         77WJIVN7ohflfuseyw6hJJKzseZelFOrsaR3P0RCN5wVWXlMfinbSxSXGMaNyrVjp3nT
         0k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHc8XSw637FJ0GLoexd3QwouyWxoaR8yvfc8r73VzIY=;
        b=Q9fPVAAiYO66YvcvVO5J6nNN02Burxib2KpNUCJEDOZQqs85YMUwjHNUXFW3a3QtKW
         yK9G+knhhm51bQNoVyF0XSMxuUuNTDQBTn347FErxtXHh4N3cwfTAi94qiNbUUeYtsgM
         nHQvChO2TCsoF1yDIvelksVhkgvrt1j2SSFdd51K85Ko3Vb1DKsKVgBiC/LmPw4H7hts
         jomqDtAp4gcyGHlM4AiqqoA7bPRHSDq9SD9Da0uC8a4EHno/K0NQwAW8Gf7wKLlNA1jq
         2DliPGW7i4IalSY6eg02dkgBaihaX6L9KBpz7Of5IV/QZtOJkdF+ejzucPbhOEQH3qoC
         9DlA==
X-Gm-Message-State: APjAAAXx3h6Op0kcqTdWRKlCrvNDcVpJTVIFL1iTjOOcJzcbh6DlAXYV
        iF5WJAN9zQ6OFPp6fcqmwtu4jW2MC8EZBm88TQCd2hvZ
X-Google-Smtp-Source: APXvYqzdISxAyqa8hAJ51N3HswStU1X8+b1dLQuTvju4822k5RHtA7GOdvMSD0jyHflc095e9tkzm2lRKCPbvZiFgV8=
X-Received: by 2002:ad4:5241:: with SMTP id s1mr7062376qvq.106.1568010798243;
 Sun, 08 Sep 2019 23:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALD=bdPVvqV2CPSuzH9bJsRta_EFVAaAvYM7p-K9CFQLGFPZNg@mail.gmail.com>
In-Reply-To: <CALD=bdPVvqV2CPSuzH9bJsRta_EFVAaAvYM7p-K9CFQLGFPZNg@mail.gmail.com>
From:   cruz <cruadam@gmail.com>
Date:   Mon, 9 Sep 2019 14:33:08 +0800
Message-ID: <CALD=bdNDnq63cEbNJORjoXV=F8tDwQcyx1eAK9DAASrWvCLJew@mail.gmail.com>
Subject: Re: MHI code review
To:     sdias@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, truong@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sujeev, all,

Is the code somewhere in a repository for review?>

> Hi Greg Kroah-Hartman\Arnd Bergmann and community
>
> Thank you for all the feedback, I believe I have addressed all the comments from previous
> patches. Also, I am excluding mhi network driver in this series. I still have some modifications
> to do.
>
> Please review the new patch series and share your feedback.
>
> Thanks again
>
> Sincerely,
> Sujeev

cruz
