Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816FCC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D83620692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iItYx5dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKUQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:46:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37075 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:46:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so3189625lfp.4;
        Thu, 21 Nov 2019 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjangubdYbmIqePnQ2tFTagrb21HEQtT8HpyfP7ti1w=;
        b=iItYx5dQzTP531ILoUqhAXs7e+4wRs6j6pWyYQQxjrmpyioKzvJb36V20DpUtFeF0u
         PbRiDJUbyJpSR0WWRRJUwwMNbcuVvOrG7VUrV0l2bMogckdzTreDbhs2uHNWoQs2tnri
         rfyy4wsFfGe5IRqit3VjlaCz8F3hb/Op7pd7vkWM25vWC/qSvN5JvCL+7PL0kU+kQyUa
         WFr8ZuwovAYDixeXnydSWN3h6rAi38rxOc/Q1aLoYnRcqfgKim6IQwDYG7vwy/LRQab9
         E7O8FOb97tbHzP0nGPpIJlx1tvgWR9lAzFp6/8VfS0Voh7YqTYkZsU3yHw/4cIrTmHTW
         S/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjangubdYbmIqePnQ2tFTagrb21HEQtT8HpyfP7ti1w=;
        b=BVJpjxy5jAQMlFT+IcknHO6rzI70j+E7LOo1Rk8OQuyF+hKelcbQiGBJEABW4njS7P
         UnIOd4/VSa5ExxZObvBD7hwosNAa9HouQESUBDDfIXW3NUIaqc/hSDzyH0T7c5oigOJw
         4hO1kpRCVxwDd77DktJIxNQpdzJ7F43XOcRxoBFchDIgxhGvbl5nBp6LKgNDrF0iBUFC
         zcs2eObUfkMtbZKcvHUIHuQusUYqx02Yr0Z49I5q4pK/rMVjuVLClKmm6FBTDxJa6XkN
         JvIxfW2wfEgQGv4KiN/hjGppdEGXBGOHf2HC0ndDpJZFbgu1QHeScF+m4QMhMIZVKWd/
         h7Pw==
X-Gm-Message-State: APjAAAVF8jUHCpIIkZqL9FSPO2zp8N2BlAqAhkRizNGtC8EY1V7L0mJa
        42zmnWVNOUq16ihbz6Fy4PNRewcb1yZJOgKT43Q=
X-Google-Smtp-Source: APXvYqwt7Q3Tcz5l9BHsHKlZA/wVWUZ0x2W/W2EvB1/diUYJozdnSbuDZ5tPKX3zSB6GmSvliMB927yOQXDkS/YKPp0=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr8591591lfn.44.1574354789928;
 Thu, 21 Nov 2019 08:46:29 -0800 (PST)
MIME-Version: 1.0
References: <1574332142-7130-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1574332142-7130-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Nov 2019 13:46:31 -0300
Message-ID: <CAOMZO5AHd7Sucj4pjVnFt_iGexMk-2_ENp4D3xDQe8PPqaoqdw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: clk-composite-7ulp: add lock
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Nov 21, 2019 at 7:30 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add lock to mux/gate/divider to protect the access to the register

The "access to the register" is too vague.

Could you please be more specific in the commit log and send a v2?

Thanks
