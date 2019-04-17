Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35703C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98AF206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGHfEQCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfDQRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:47:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39593 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfDQRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:47:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id a96so12371470pla.6;
        Wed, 17 Apr 2019 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9APsGckmzihOO9dqTe6ALmt4jv1tDX1soBQUw6e5hQ=;
        b=bGHfEQCN0sNNZq0deH317oh7k+UaZPbNhUBnNuhANveMoegF7dVk5f50xemkg+4xU3
         Pf8EmyPghGz6BwS3+Iawo+QqZ9rrWTGBT9h1aAUyNPMkl15pBaejRuX3BqJljACjtIVe
         FM71ZmV6D3aK5NhMMeaXeldPA79bGRRyeoKgruq7tZE6anxo4+363JyoyqYxU+x8WwDk
         VxbqLIYeqoc1gZRi5BsyyAhSFBECYzEgpXLuXePLaUnPAcU9+4I4mxbPGEZBlTqWO0C6
         ylXhBGlgmCHScUYrikSLD0SJxqzFll0rdVG8+JRiig9+l/OLqpo2NGVyodo1O7m2e41T
         67hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9APsGckmzihOO9dqTe6ALmt4jv1tDX1soBQUw6e5hQ=;
        b=aAmUax7u5x1I6/+Vow5LmsfKEF6omHf87VIfLIvXvd3ZJzaHxM/LKhnX17fKpWMjMN
         R4xOtPrrDNz2fFKxSwjHnrDYXFdUR7mu6JTgMkrNVbyC8l4VpBxSaEAfHr5Gf/tSvnmB
         Cm6GdwzuIqyiOc9RG7P5Q+t/PL0+QPKiCrMM4xkxMQiW5PZGHQszkbrJOSpWAJ5tLWEG
         RZW7+xC5VqIT3TtpgErYSFIthX6EI5XLQypSTje0rsLGk0JYDDFGcTP+ft6ujzkrffC6
         C/IfenHh/x5A7Z4EtU5OeCX4gAGz7opuWuWCDFj9WlR+LC5hFDiAoDJGWL4ODasMNEaA
         JeMQ==
X-Gm-Message-State: APjAAAW6+lNrig0UgGDroUAakQCFVvZ7Y0JMJyYW8a/Fl7Jxq5uMVCn6
        0PflhJyn/la/9rsvGSt+FLs=
X-Google-Smtp-Source: APXvYqxRA8oDzw1zSMNBhh6VDHqVLxshxm8y+1iglurRc82RrTB98wBD9PHrPjXzlQ4awxP2H07u+A==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr87135181plc.175.1555523250263;
        Wed, 17 Apr 2019 10:47:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6sm86682439pfb.171.2019.04.17.10.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:47:29 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:47:28 -0700
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
Message-ID: <20190417174728.GA17706@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
 <20190417174337.GA16749@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417174337.GA16749@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 17 Apr 2019 14:13:52 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > 
> > > Em Wed, 17 Apr 2019 09:47:41 -0700
> > > Guenter Roeck <linux@roeck-us.net> escreveu:
> > > 
> > > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:  
> > > > > Now that all files were converted to ReST format, rename them
> > > > > and add an index.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>    
> > > > 
> > > > I applied all patches except this one, which fails due to a conflict in
> > > > ab8500. I also notice that this file has not been touched by your series,
> > > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > > and has been missing all along. Does the missing patch possibly touch
> > > > Documentation/hwmon/ab8500 ?  
> > > 
> > > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > > its size or due to the number of c/c.
> > > 
> > > Just bounced it to you. Please let me know if you didn't receive it
> > > yet.
> > 
> > Btw, LKML got it:
> > 
> > https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> > 
> patchwork didn't get it (or didn't accept it). I got it now.
> All patches applied, and pushed out to hwmon-next.
> 
> We have one (new) unconverted file left - Documentation/hwmon/lochnagar.

Plus ir38064 and isl68137. Lots of new drivers recently.

Guenter
