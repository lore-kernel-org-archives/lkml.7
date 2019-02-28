Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F344C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EEF218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9BoY2Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfB1S1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:27:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34504 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1S1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:27:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so18620456oty.1;
        Thu, 28 Feb 2019 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO1e3jzRxLgn7dG4jZhPRXl0Hwlf4a4TbOgy3DtPBig=;
        b=i9BoY2UxF7ba7raszl8MWvWkefmgHopTTd2qO7I9DQw5DinCbFW2a3njtz0pvotzKD
         nrNF1ithb4f1sTDwAoQLn4LD3KUlZnSpMxYn1tcuJsFAJ9XtPyTcfhIRcADjvHB7HDew
         MxJWm4YdsBcjtTV+iY/J5SDOvKf3HmdsoK/l8tXi2cbAm5t669wX9TzQzwHXX4S9P3UH
         2e/M3wZwliAb+6HDHknfL6/NwKk1inFGcBGHTNmpJK1SFW8yxcFCTfaxYvc82Vs1YnHX
         cHKXMBvryE+57bbvqF8p+yo++7NZUN4iIkPeEVKT1JwAD23N3srozbOyg2UUigtGb/NM
         295w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO1e3jzRxLgn7dG4jZhPRXl0Hwlf4a4TbOgy3DtPBig=;
        b=g8h5AfsilSMz6fqkJHOLGeNKj9uQH18u2ZMT46NzHMiF6DS5hRUfFH+3s4AY/gOfe9
         rAeMqGOaYqM9K477stvTVPu+odiSfrO61VqE3JWlzsthZIP6gDDJsmCcWDc5fqDY7fFW
         zgtGBDgT+E1vOBlscAqPR9SvwqM3MVVi33RmmHjsnmpi1qbZvXMFiOcDM77cD5N0J/Kv
         62SuWw4QPUqYt/UFdb9Q/CE6Mntp6niGDpxWykcTZFK0ql/CjatmWE7Rm2LKO/X9pKb0
         cS9D3fnN7oHrKg6gjFw1NZYQrzNnfoMKF30x3n2AH5YuEMEnkpWotIGKomHCHGNmwi66
         4IpQ==
X-Gm-Message-State: APjAAAXWi/rZM9kcvudLnebp7WDnCRGvyoHO8bKlvURxqMeyChoQfls5
        9ZkQ4h1QFItqq43vjdP363AGZbnnSoF9CzPJvPU=
X-Google-Smtp-Source: APXvYqy7Iz44tah1DnUwjXlYCRXVtURC9B/uYRwLEK6ANuSnkVDz+8zYZUsVOi4hyqFF6KgJJvJfNhglFDk9m9ntLl0=
X-Received: by 2002:a9d:6d94:: with SMTP id x20mr673627otp.78.1551378443868;
 Thu, 28 Feb 2019 10:27:23 -0800 (PST)
MIME-Version: 1.0
References: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com> <1551321831-11597-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551321831-11597-3-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:27:14 -0300
Message-ID: <CAOMZO5CZrCZF0iFnn0qTpKvpUTP_DQSDEsNSGRx=mOSYPWpEGw@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] ARM: dts: imx: make MMDC node name generic
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:48 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Node name should be generic, so use "memory-controller"
> instead of "mmdc" for MMDC node name, also remove "mmdc"
> label for platforms with single MMDC node.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
>         - remove "mmdc" label for single MMDC node.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
