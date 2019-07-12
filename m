Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E0C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD66421019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W96Oxc4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGLGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:49:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37570 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfGLGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:49:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so3882565pfa.4;
        Thu, 11 Jul 2019 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yl2NBfkpJwuLVMdw2asUgipY8zUtavbdlBnw5Oda4sw=;
        b=W96Oxc4/aAuet9AVNiGnaebeH/1ChIBWNe2gJXHOWtIugBHhSWnGr45Zc/Hv+9CrSZ
         vVOfQTEfKMxL4jFYGSO9LKpzFiygIJRJGUlxi4tb51bx2hcaRkdNqTjKVP9auNIq5znA
         XJjHbqQGG2qzzhHPzX5qXoOls9omqqjgBk/WIf6GRadhwt9BmmBxm+A5oplIZ0Q4RlO6
         ZpsCg24FV5zP7T2RBr/9fwd7eGpXb4G3HaGRxiNo+P8KzIPadknhHaJDvBo4iaXJgaKP
         Zl5FBx4kUuAmrULjRnieGVTfJ4jYXXBcUNsy9ZT34LHhPRBheT2YbuWlhLKfhULLwKM4
         tA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yl2NBfkpJwuLVMdw2asUgipY8zUtavbdlBnw5Oda4sw=;
        b=D1KDsq7VyW7/y22sYjEU6XAUERPTbOIiuiUd1NJKhw43oo6fLLPNcLLlHXmjbFuj/E
         tm7ZRz0lxavciOkX52Bq+uVx8Iqv3EP1/MKIgX3ZOca+jDvdeq5Oq91bqUmRxDA33SYK
         xUrH3KJIq/hKgiB41TLTvqfR9I7rjzt2heaf2+mP/Djo8fvCZ7+hTeZPkWa3XrU7cMQ2
         n1SwRC1OSi4A6eYqs9vdcfHWsV2JfOtfx557ACTfFwGD1/wBHy1QxWbqLka0Rks6HyvO
         ak5YUBL/F85h3IZIMLPwcUa4B8QckQiuI3YbZ5twG0kgk6b51p6uhYa0NwIbBf9hk6UB
         G02Q==
X-Gm-Message-State: APjAAAVSUQAD880IEGAyQrTEeR3yVvYA5OPIQTCHxNmjb9wWV7wZD8Zt
        +4fv7ckVekdw1vIKn9ZW/YU=
X-Google-Smtp-Source: APXvYqzc9hlWIPnDtxvJ5ooZ4TMTYCWxxWg2YPHvVp1mVQyYbWfl1vDwWW8scF3TiKrIyaGHANuDPw==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr8830830pgf.230.1562914140959;
        Thu, 11 Jul 2019 23:49:00 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d15sm15704596pjc.8.2019.07.11.23.49.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 23:49:00 -0700 (PDT)
Date:   Thu, 11 Jul 2019 23:48:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Crag Wang <crag0715@gmail.com>
Cc:     yjjung@melfas.com, jsj1012@melfas.com, leesh832@lgdisplay.com,
        Mario Limonciello <mario_limonciello@dell.com>,
        chrome.os.engineering@dell.com, "Crag.Wang" <crag.wang@dell.com>,
        Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: touchscreen: add delay time to device power on
Message-ID: <20190712064858.GD150689@dtor-ws>
References: <20190710025859.6025-1-crag0715@gmail.com>
 <CAP-8N0hTEXkK3iqGP=+gtuVVcqo-+KYHC_N6+8Q90ndf_UVJpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-8N0hTEXkK3iqGP=+gtuVVcqo-+KYHC_N6+8Q90ndf_UVJpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crag,

On Wed, Jul 10, 2019 at 04:58:40PM +0800, Crag Wang wrote:
> Adding more
> 
> On Wed, Jul 10, 2019 at 10:59 AM <crag0715@gmail.com> wrote:
> >
> > From: "Crag.Wang" <crag.wang@dell.com>
> >
> > Delay time for MELFAS MIP4 controller is required at power on stage
> > regardless the existence of GPIO consumer lookup from devicetree or
> > ACPI device table.
> >
> > There is an issue if GPIO ce is undefined in the ACPI results no delay
> > time for deive power on, the controller ended up in an abnormal state.
> >

If kernel does not reset the controller it should not have to wait for
reset to complete either. Since your firmware resets the controller it
also has to conform to the timing requirements.

Thanks.

-- 
Dmitry
