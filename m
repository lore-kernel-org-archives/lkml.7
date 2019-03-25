Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F202084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpjuiVYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCYN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43763 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:12 -0400
Received: by mail-vs1-f68.google.com with SMTP id i207so5334821vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cURW48ffN6AjksZ6UBs0FTtoroHm/fGGjxVCYC3fVDE=;
        b=VpjuiVYl2vcM8l9dfwfLMPv2H9EWA0CVqaKAtCPvAkv80PiCqaINfH+YYcC85k4RMX
         aLRfslh6S6nU8Helk+ee/2Nxyzy8XhdifiA8YyfLBniretx2iqMpz5rEhf8h73UrQXV6
         lmy1LbcMoEd3quLRiT0COhOOWRVd+kJfa9s8qAZKUJLa3GrzNmqYnS+w195femZK7AMa
         ZQ7zNDr0lcdJeRSNrx8frPG15VoU1ij35uNnqwd1/+EnSG3xBA/weVNhsajrx+3vw5SG
         OFzp0mwqG7v68T5GclS03ub87MrOXKXruMyDrP37YVIrw6U/8BWC2Uph5dPIV7j5t31y
         JgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cURW48ffN6AjksZ6UBs0FTtoroHm/fGGjxVCYC3fVDE=;
        b=jcDlLkPDsHrxaYtfVsw78WNgZDynSLjjPDEjupCl0KUY517fvEUBaipd8/3wTyaRaO
         Gv7QbRFkDlNVFaXwqXmg5NMj7MkAOFXp2gWZ1+chmTZleBCl4so0Vq9+OscPGEBFCY6j
         mIN7eH10l5wTm1HwZwoHFeRe4NUuzijQNvi5ZlGUsptv49rRTMl7g7EM+ILjDHmtq6hH
         sRUINuFvZhux/RYT3OfzVlTrL6nKSCUTYDhOIb9QQnMtPFYHlpIqFLhgDEpyK/rghMwG
         parpiQ6I9ulteeYgd0ZntJCQoSfEbAj5yxW+Udq230M7VlHUmEkZ97flTOqRIA/0UmzZ
         kwpg==
X-Gm-Message-State: APjAAAV1TbRNDsDb0r7KRVU35Tiwr+6SNRH8+VMBOExSlnAqAGX/wrLc
        12vTU4vY35QNm/W5Gq+kpvNDoUrQoP1SqVELMCbMvP6S
X-Google-Smtp-Source: APXvYqwi9U23Aqj9/iktjbdgYTN6jyTamaLUMIqcmR0knQNO0TZZOm2QWEVK6BblDXaMhIlWPw7t8OVv+WPJPv40Efc=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr7594281vso.165.1553520431547;
 Mon, 25 Mar 2019 06:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200010.GA14527@embeddedor> <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
 <a69a2138-0515-82f7-ab32-21d62c248829@embeddedor.com>
In-Reply-To: <a69a2138-0515-82f7-ab32-21d62c248829@embeddedor.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:26:35 +0100
Message-ID: <CAPDyKFoJPZBWZk+htuuvDyAYRVMML=tOMrij5P1v02XGm2DU3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> @@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
> >>         default:
> >>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
> >>                 /* mrq can be NULL in this actually impossible case */
> >> +               /* fall through */
> >
> > Please make this one comment.
> >
> >>         case USDHI6_WAIT_FOR_CMD:
> >>                 usdhi6_error_code(host);
> >>                 if (mrq)
> >> @@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
> >>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
> >>                  * the page
> >>                  */
> >> +               /* fall through */
> >
> > Ditto.
> >
>
> OK.  The reason why I didn't do that is because the line would exceed the 80 characters
> in both cases. But I'll respin if you are OK with that.
>

What's wrong with having several lines per comment-section?

Kind regards
Uffe
