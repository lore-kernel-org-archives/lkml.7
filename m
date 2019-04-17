Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B26C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3421C2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqA4BWkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfDQRnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:43:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfDQRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:43:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so12318732pgk.12;
        Wed, 17 Apr 2019 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xb4dDY8Ht5vsPhb6Ii7KBS3ZH6iBZMm1tLBFEdnq7bo=;
        b=BqA4BWkJoVPi6+PwGHhsOWzyFx1IDgxa5Fcya+P9/nbqlF4qTwByIkuHJDpBRgFzZG
         Dk+74/3mVzCPZfvxNNRQvWkX70qwNGeXcKaEbXz6BKcmH2XeB3G/kdyrnWVLPt+kW6Wt
         1a9U1GGZXUx0/2JRaWXGb8DZWDMJKSGqI/LZvzcjOP1g4ZYBGRO16VfnxVq1jGgKi+U4
         Tvc5cy8hGYUvO7UMKvSpJSQ6aijiJq31topFVQKEyX0vC5LixXp3Eal6IYknXQlXnre7
         BStMbDJvw8IC71pT+zb4EnNcUAvRB1aEPOiuShfbKutdrVnGNaoPGw5jxTn0J7VZ20UQ
         9U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xb4dDY8Ht5vsPhb6Ii7KBS3ZH6iBZMm1tLBFEdnq7bo=;
        b=tFYgmg859gpzvmL4XgmCd9Ddvk70PGxGKzi5VYoV8lvk8dYLYh9EI0fII2stycByor
         vq549WqBAXg2wtAblSI1CEvwqYKcUhUxpApbH6ZGuWhWV6RUmAHKFiqM3C9Ixa8l1LgN
         4VAZmabqmhrDjq+Br+L8CfS/YQcGr26UGXP1KXgGN+xwPQXwOwjCRM7M5AI0omb6Q/at
         M23OVdi7Z0gnc8x3Yd960udlxMxFxA43XfaguzvLaGoDlvckOe11eBFM/o7xK/081T9g
         WQDy69qzmvM5TbQzdUsIFRIJQB+FtElmPpRl+Hw9NeM9iFMnYBX+WFWUGUu7mbUtXQqA
         Ei+Q==
X-Gm-Message-State: APjAAAUATJSrk/Vn8P4T/B6lKtKoAZA0HkLGAa//0dCtt60ebdbKRAaj
        x03jv+zsf680uuPiuBmX+5A=
X-Google-Smtp-Source: APXvYqx3fuy7b8UJvMM0ooV7d7Bhu13mTndtGcb1/KeBvuhFe0R+J0MnnnXU3Buj0QbQJnti18Lv8g==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr83242355pgw.76.1555523019795;
        Wed, 17 Apr 2019 10:43:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x28sm62632792pgl.38.2019.04.17.10.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:43:38 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:43:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dirk Eibach <eibach@gdsys.de>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Huang Rui <ray.huang@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andreas Werner <andreas.werner@men.de>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190417174337.GA16749@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417142215.791df5e7@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Apr 2019 14:13:52 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Em Wed, 17 Apr 2019 09:47:41 -0700
> > Guenter Roeck <linux@roeck-us.net> escreveu:
> > 
> > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:  
> > > > Now that all files were converted to ReST format, rename them
> > > > and add an index.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>    
> > > 
> > > I applied all patches except this one, which fails due to a conflict in
> > > ab8500. I also notice that this file has not been touched by your series,
> > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > and has been missing all along. Does the missing patch possibly touch
> > > Documentation/hwmon/ab8500 ?  
> > 
> > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > its size or due to the number of c/c.
> > 
> > Just bounced it to you. Please let me know if you didn't receive it
> > yet.
> 
> Btw, LKML got it:
> 
> https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> 
patchwork didn't get it (or didn't accept it). I got it now.
All patches applied, and pushed out to hwmon-next.

We have one (new) unconverted file left - Documentation/hwmon/lochnagar.
Can you by any chance have a look into that as well ?

Thanks!
Guenter
