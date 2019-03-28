Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F802054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI0gkSGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfC1Q2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38904 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so4798787wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjqpdF/4irGRhXMXvFyiZX4Uzh2pYzNeu2p6BF8vm3s=;
        b=ZI0gkSGj9YWtOWXq5pjieAyqu+PKd+cCY1A1QYsSP4ahghbL/RaGd7+0BhMUutgHZe
         fn/ehkUJ1wlgkD9mv6Q/ipOd8bXwGxCpW7tYQO3X6c+kEelsYf+r5Ix5t4YADNokMqJd
         cjxY0ZSbpG0NMJiDNCUDhC/8NrgpWdodBzej/eVPHIQVGTpMWbQNNkp5z6K4DKGcPDU0
         yhejFt0zCXodyO5cZf5Ze6/ovfVzrk2nMWlmEp/w1SAie7VJzkmf8YmOa/6iZdvVYcgq
         ZNs5G9k6SQqhLBqjn5y/8Uk8y6nn7N2YWYSNjtHY9JOkriFqaqqVIITSRzw1HcL6a5n9
         nyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjqpdF/4irGRhXMXvFyiZX4Uzh2pYzNeu2p6BF8vm3s=;
        b=m22hZ7EZkVYJAYOkF/ZgQUJ1roRz57DHEUWCn2Q6VPrJYHxB6M2UUoidB0khMbldV3
         zSG5tL/JkYJoy52LLFl8EEa+QSIm1auun3TRKJtCIvIg51kJ99xiWuJBvPgiI6nBlMXn
         BBHkR1nsx5BeX+BA/xNP16srEQKKL1R5fNYFxFoolVoTi0Cd3n9hNe4rSZKZTeCbPzei
         OgtiG9BkGYbIA+nDQ5UK35Zq6HeUr1I+tQ0vOdI33Yd5hzRpngNOBs+8EttKQuv3i2WA
         i54P7SId0OHTgpn7WgxKof0S+EdXEaZm0qG35/GMcLtYgOAEfL7bW8T2tAJEDOiF37ES
         lMvQ==
X-Gm-Message-State: APjAAAUtPhyg4EilkEUFKGIvKQVYX/yfl360aRMGNMb/bh6xDSAkUL7F
        y5baRSlZqaXeLhvbiKxWVB1nTW53yu9d/XLsWZQ=
X-Google-Smtp-Source: APXvYqykoylMr2Fwbgbt2yodYL5BWw2NBkoE91Q1CY6wNBqiYlBbqGEhwcYTu8/1MqDMHWfoIRqsGHQ4+mKQd+BzVr0=
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr593217wma.38.1553790528866;
 Thu, 28 Mar 2019 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190227165018.12911-1-andrey.z@gmail.com> <CAHtQpK7h=kAOJHa1K7+mzq09=nAd3XSN-FxAPkjts1WrADKnCQ@mail.gmail.com>
 <d3f69e34-f408-c163-f85f-bd3e9338507b@kernel.org>
In-Reply-To: <d3f69e34-f408-c163-f85f-bd3e9338507b@kernel.org>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Thu, 28 Mar 2019 17:28:37 +0100
Message-ID: <CAHtQpK6MF2daF8S_J3K3XAZKvOLvauRjA+-Ofp7DdDiqCLLT-A@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: socfpga_defconfig: enable support for large block devices
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 5:07 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 3/7/19 1:43 AM, Andrey Zhizhikin wrote:
> > Hello Dinh,
> >
> > Just a short ping on this patch - do yo think you can accept this
> > patch and have it merged? I'd like to know whether it is planned to be
> > integrated, as it might be beneficial for a lot of socfpga users...
> >
> > Thanks a lot!
> >
>
> Sorry I missed this. I've applied this.

No problem, thanks a lot!

>
> Thanks,
> Dinh

-- 
Regards,
Andrey.
