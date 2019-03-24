Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B421820989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcINz3Dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCXTin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:38:43 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40372 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:38:42 -0400
Received: by mail-wr1-f48.google.com with SMTP id t5so7696582wri.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxPQn47z1rerqUeT32MzpbgUqnjEpKNdxsAsub596Bc=;
        b=gcINz3DyFiH48di2rqs+djREDnobkTMixd0aOtgM2kxyQ0c8qGx5YUn4AhH5SUIIOo
         rm4wpBPLNAYEssHMKFPgt0x4C8p5mx8MvUjkvIwzURwAp+pf1Z64m7EGPD6Q/OjEpUve
         eRrkrJ/NGEs3DyfWyFnuPCg4xW0rmqohg0vNr+k2l256SV5V7kfVN6tIiM7DouPX8yqU
         DUTiXEWKCbei6lH/k6XhXwArRNgWcOlBVfimlyJBWag4fLCBkA3OgvVyeGe6SOd9S5cJ
         ByxaGPKcxMWh/75HMEaMbA+BULMW4YN7R8oGFQO4UrZJ1FRqebPL6wVMww3W3Zcv/JuH
         Z0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxPQn47z1rerqUeT32MzpbgUqnjEpKNdxsAsub596Bc=;
        b=rbEZ7eFuAzbp0YcpsaVzgGb2kFUsJLrc0qhTT6ztJlHmXeD7xx8rrngeQGO4AGUWTC
         Uo799/IixbiBFhN3Pre7bb2kKCAupit4ZXnhMCvjNCpI52sZDyoHtW4+4K3GLQONu8ng
         /RWJwJwszDwRgubU6gM3YdB1MtopUc2Vu6QElWY0hOnH8lS8asncYViRE0EUP50xH3AV
         S0iGT1/dKQSgZGg+MqQ/cMIY/x4mLZut89D0E6/wiHnKGuRc2JxYA7r4XBuhpVjk2kAF
         IoZIWEwhnrWHsp0PPmlwffO9BqQ0j1nTx0mXvCQEjn/RL/+n9eKfYKETqmLafSxaoZZf
         jQeA==
X-Gm-Message-State: APjAAAXCItixEDy49gETbEZ6FyIlarSb7WYyr9aY4ZVlSPuEIvJiFTic
        qWlelbsME7afTp+K1GSIjcQ=
X-Google-Smtp-Source: APXvYqx3pexjrYg7aFU//b1McXjRl1yeBqIlilhI/VyAD91N0lwg6TYmEA4n4oIziOP0le85vwD0Uw==
X-Received: by 2002:adf:afee:: with SMTP id y46mr13076174wrd.217.1553456320900;
        Sun, 24 Mar 2019 12:38:40 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 132sm28564539wmd.27.2019.03.24.12.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 12:38:39 -0700 (PDT)
Date:   Sun, 24 Mar 2019 19:38:38 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current
 mainline
Message-ID: <20190324193838.ubiljot22zhf5mjq@debian>
References: <20190313064557.GA14531@unicorn.suse.cz>
 <20190320211813.GE29968@unicorn.suse.cz>
 <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
 <1572645.oXzt2vILsi@alaris>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bgpybydaqq5sus73"
Content-Disposition: inline
In-Reply-To: <1572645.oXzt2vILsi@alaris>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bgpybydaqq5sus73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michal,

On Fri, Mar 22, 2019 at 07:13:23AM +0100, Michal Kubecek wrote:
> On Thursday, 21 March 2019 23:43 Sudip Mukherjee wrote:
> > HI Michal,
> > 
> > On Wed, Mar 20, 2019 at 9:18 PM Michal Kubecek <mkubecek@suse.cz> wrote:
> > > On Wed, Mar 20, 2019 at 09:30:59AM +0000, Sudip Mukherjee wrote:
<snip> 
> > Can you please check in your VM or machine what do you have the alias
> > as? It should be either in "/etc/modprobe.conf" or some conf file in
> > "/etc/modprobe.d" folder.
> 
> You are right, this is in /etc/modprobe.d/00-system which is part of
> suse-module-tools package:

And I was able to reproduce the problem using a vm and Suse Tumblewood with
next-20190322. Can you please try the attached patch and test on your vm and
machine and check if it fixes the problem.

--
Regards
Sudip

--bgpybydaqq5sus73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 0171b8dbcdcd..f87948fbfc34 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -274,7 +274,7 @@ static int port_check(struct device *dev, void *dev_drv)
 int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 			      const char *mod_name)
 {
-	if (list_empty(&portlist))
+	if (list_empty(&portlist) && strcmp(drv->name, "daisy_drv"))
 		get_lowlevel_driver();
 
 	if (drv->devmodel) {

--bgpybydaqq5sus73--
