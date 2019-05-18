Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F75C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C6221882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX8Jm3WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfERCMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:12:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44306 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfERCMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:12:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so4120426pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6dZilZOrKD/+f4wxtqkk21JzGk5u5RhKsFPFxYt0T2U=;
        b=oX8Jm3WIfeGs/qVsZiRuWjgxZ/76rfWmJ/omU87ATD4OJ1kbpTezQAhoWHQyqKBAQz
         8us0/wKPxGGSiRrvIPabw6/9xjAfVjr2U3t59wazZA1JSVzC7R6fwvFVvEhtupoMoeEl
         5zg0z4EqN1Qi0traay24AxZ2SdcRZbqxBlnhtyUKoPcjc+OGHR/0Cccs6dP/1cNtwtdc
         5jDC50RpUi9IgHJZ8QPrjFNGD/o4Jh/B8jvneUWeldaQwbYy7OXnyG1XOiCoJhTCA63/
         DyRK8QHkmyQjPYf09CMEEh09DSsz7RoHyTMwQpOLYYguGY1ShYmjI9VxqG/6h3/PVX73
         NAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6dZilZOrKD/+f4wxtqkk21JzGk5u5RhKsFPFxYt0T2U=;
        b=cCgHZ7ORVTj52zPPPpnvp8HNZ8vlGaxZZ2/yIVhlXDQaf2n9IHTXMY67QBVE6AJQKC
         oi7km2CCc2/dpVdA5VCI4/myjRnnLdZVDMZNL1TG2k2Df2rtUMhKK9QT+elyE4+Z7s0J
         bYwuOk1lDXe+VtxM8SmVfuP94tTW+rGXO86+DPDuclUL8TZdN2gnLqtNpg3M3STxB+hv
         yFmVtPkjAbOShxVQ3XgdkejO6iKdUPj0zZA9HUGgWG/12ojKfrZgzbNxnHy1atPzxOr5
         hcPuoITQPIceHtRpJmBdBacFBGllPTy6Y625P7Tzp2/qttBIH73FJ/UQGgzWHJlXbS2Z
         11Gw==
X-Gm-Message-State: APjAAAUYe7/Qc5vauxHr8RTqhaez7YW8x8aH096/Rg/Os/4Ipc9m6eH0
        tg+9RFA9cRbfaYAb/mLYJwXuKGys1/o=
X-Google-Smtp-Source: APXvYqwEcW3UZ8XmJ7VhPz866dIrHgZKG7TF108rS7GCiZM6v3LktiQhBJenT0N5C/z9re6fegcdlQ==
X-Received: by 2002:a17:902:63:: with SMTP id 90mr7240296pla.342.1558145526909;
        Fri, 17 May 2019 19:12:06 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id k7sm11847661pfk.93.2019.05.17.19.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 19:12:06 -0700 (PDT)
Date:   Sat, 18 May 2019 11:12:03 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3 0/5] nvme-trace: Add support for fabrics command
Message-ID: <20190518021202.GB31204@minwooim-desktop>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-12 16:34:08, Minwoo Im wrote:
> Hi,
> 
> Here's a third patchset to support fabrics command tracing.  The first
> patch updated host/trace module to a outside of it to provide common
> interfaces for host and target both.  The second one adds support for
> tracing fabrics command from host-side.  The third is a trivial clean-up
> for providing a helper function to figure out given command structure is
> for fabrics or not.
> 
> The fourth and fifth are the major change points of this patchset.  4th
> patch adds request tracing from the target-side.  5th updated, of course,
> completion of given request.
> 
> Please review.
> Thanks,
> 
> Changes to V2:
>   - Provide a common code for both host and target. (Chaitanya)
>   - Add support for tracing requests in target-side (Chaitanya)
>   - Make it simple in trace.h without branch out from nvme core module
>     (Christoph)
> 
> Changes to V1:
>   - fabrics commands should also be decoded, not just showing that it's
>     a fabrics command. (Christoph)
>   - do not make it within nvme admin commands (Chaitanya)
> 
> Minwoo Im (5):
>   nvme: Make trace common for host and target both
>   nvme-trace: Support tracing fabrics commands from host-side
>   nvme: Introduce nvme_is_fabrics to check fabrics cmd
>   nvme-trace: Add tracing for req_init in trarget
>   nvme-trace: Add tracing for req_comp in target

Ping :)
