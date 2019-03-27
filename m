Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E49EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B212075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y23wxd61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfC0CAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:00:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32880 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0CAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:00:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so54469oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CBphYoVQQckqyA3coFhANhcw1xtzWp8xlOjouDnk9w=;
        b=y23wxd612d/6g1e8ZWCwS6lrfT03ATXQVNPs0A+TmOGjJDhiajndFHrtfOxHrUhdnf
         k4bHfo3arwbIZEkktQ9vv2Fn5y7owDUCB4zlWEjg8M1i0zyRTjdLGAf98JyMK8bk1yag
         okXOfbZoolYIGTU/vFS5oZUu0jp/VA/XIYIY/9XOY1Nc7IbG9EjlHXWd+7Wshm8ZNGk/
         lYCZh+Z2Epzrs0XdJJLJzp4kFNIBopYhJg8zjueqbpCZN34+0fAGAyHclFaRoC6HHXxG
         R74B/0/JZKsH9XHGdkmcnNkxFG9qp1FGYHKaDlFgS9wpMJTgIilcbpGz0ZYQ9NgKftP3
         DJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CBphYoVQQckqyA3coFhANhcw1xtzWp8xlOjouDnk9w=;
        b=qKhk3vWOPYZGgNFQfmsp8dsJXfY2uDr4vmb1/NGPLY0tdGQt1onN/vzZrm9/ef/2d6
         iLb+/smAW+JcB3TagarXvpaq2H/NvzjxwK9ywmO+DmXy7MKTdKO+VFvYxGSI5KW4LA8b
         AkyvmzODc/DjM41V4FD6Q29dEeLJkJ2R+xguVJC6ueWOmMlVd0MCoPAZ1AJ3vIWGAZVd
         qRfWtZkTR7pK0sT7bONKds9EAqBphuF4UEGi9LxZCLQ9aM9IzKrEk3fmHGRvdsS5Ebgt
         a2PIvPsw0SulNw6xzuCIWYIY8rjsVZ2l6kpiNK2KnkUS0BzMqI4Y6xIcE2+R3UnMsZZB
         cIfg==
X-Gm-Message-State: APjAAAWQgZ3YWv98TbQ9mOa5jmb6QiGSgouuLAAfR00m3PzfD8m6fDsA
        ArQNuxi5liCjeNETew8OTFwXgl/wb/YeQHHeZWH8TA==
X-Google-Smtp-Source: APXvYqxY+ZnDXzbsB14nGtEl0oF5Mld8wRsY3lpGQu3LPkmu7x/dPmjqeNqR5byf8UHnnSbEK6GER/HRCbklzz75IqE=
X-Received: by 2002:aca:4a4a:: with SMTP id x71mr17716538oia.27.1553652007074;
 Tue, 26 Mar 2019 19:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551689518.git.baolin.wang@linaro.org> <CAMz4kuJitF7Q76T0Hoj1-UTAjQnepEs9aQHhy=r_Acdq+RiwGw@mail.gmail.com>
 <20190327005944.GA20301@kroah.com>
In-Reply-To: <20190327005944.GA20301@kroah.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 27 Mar 2019 09:59:56 +0800
Message-ID: <CAMz4ku+00Bt0viM0JfKdy0n51EF9Hc37auKa6GPCHp8o=J6L8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add new features for the Spreadtrum serial controller
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 at 08:59, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 06:41:31PM +0800, Baolin Wang wrote:
> > Hi Greg,
> >
> > On Mon, 4 Mar 2019 at 16:59, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > This patch set fixes the baud rate calculation formula issue, as well as
> > > adding power management support and DMA mode support for the Spreadtrum
> > > serial controller.
> > >
> > > Changes from v1:
> > >  - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
> > >  - Add reviewed tag from Rob for patch 1.
> > >  - Fix the incorrect names' order in patch 3.
> >
> > Could you apply this patch set if no objection from you? Thanks.
>
> It's in my to-review queue, sorry, will get to it soon...

Thanks :)

--
Baolin Wang
Best Regards
