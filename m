Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3616C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838520663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575884411;
	bh=h73aysv3ledwedFLJtUIuKZ7YrNWC8cVeSLDJCgQPtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GvkpIMBtzZYFVvJY8WZiI4u3F4UydJhSoFPYtBOtfr6BboZ24Hk7F+LEBizm8kLZZ
	 w4d0eWBRGcjxTOOFrITfc6zAUmezQQ8tLyEFCBc54nTEINg6fhLPC8tXJYB7vuMohJ
	 cu46jjgAdEDYXjz4lyxLLj5iLIDPqWUEQ4P8BEZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfLIJkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:40:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43474 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfLIJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:40:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so11590392oth.10;
        Mon, 09 Dec 2019 01:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGVq3bos1V/b94h+qMcuMpYKpywOWJHb0vw6+K6ibBU=;
        b=geOA8P189fqQCwXo/xX6G6960N2alLCbZRu6TnYMbM4NLk5QS0CV9UQz4LP1PkuwP8
         i642qz0aizW7tiPcWFhJik8gmQVuubky3o0L5DGaWCEpcxlDMEobLTP84hTTwpqQJak4
         OAGL+qsx3sURSuFmlQuyN0bxyb9CQ2ecA1EO3n3kN13CwkRUyGrzKJnayGtM+db3THMs
         KogfyCnbGHYvJ4ZMRcktA44gEJ39Cq1fv986CfkQmtYBXWDfVwbcTfgfEPVmg0yjk5wf
         HpC12Oou/sF5UavBlpa3PEANIAktaFC+79m4+7ViyIWHARl1l3Zpv5I/P1pkOdrXXhLg
         AU/w==
X-Gm-Message-State: APjAAAUmOwef5lF1Gr/vlJ/LUKWoURXIm9AODARn0vQbu9gtCLqQCiCy
        tBtt6+SIZBeCqKccwscIbgBziQex61IdGmFYcHvS1g==
X-Google-Smtp-Source: APXvYqxOUHFAPuzZgXsg+i6LKVnhEAS2Urx+XwHaLsrDTyn7ELMIyITJi+pitJUMWrGNFqI+uogzcruBa+Z648x3eUE=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr19929555oto.167.1575884409334;
 Mon, 09 Dec 2019 01:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20191206150739.GA20167@amt.cnet>
In-Reply-To: <20191206150739.GA20167@amt.cnet>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 10:39:58 +0100
Message-ID: <CAJZ5v0g+Jb81OOZ-na_mddP-mgeAWSKDnVsvE4ofDM2tpL8ERQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: use first valid target residency as poll time
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 5:17 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
>
> commit 259231a045616c4101d023a8f4dcc8379af265a6 changed, by mistake,
> the target residency from the first available sleep state to the last
> available sleep state (which should be longer).
>
> This might cause excessive polling.
>
> Fixes: 259231a045616c4101d023a8f4dcc8379af265a6
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Applied as 5.5 material (and tagged for 5.4+-stable), thanks!

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0005be5ea2b4..15877b431143 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -382,6 +382,7 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
>                         continue;
>
>                 limit_ns = (u64)drv->states[i].target_residency_ns;
> +               break;
>         }
>
>         dev->poll_limit_ns = limit_ns;
>
