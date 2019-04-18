Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA25C20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfDRP3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:29:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51392 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:29:11 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so3933263itk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PTV7w2sFD53HDQMqtsdrCsqIcgw/TVT2YeOyBYCnr5o=;
        b=ZwbsfNoF2wE0VlUqMdQm4QRGSpBepAzSm+PeMUg1lRzgiZthWwgwJTJibYEPB+h5eh
         CkQVJTkD90LJvvb56JcOp6TyZxqHDbHY26mB+q4e7oKnGrEUMytZg9RGocADikm/q4M1
         zxWHsizKuRcFeSJ4hufwKHkWeryVwk3dgW5kVFWbDBRCwFLxpJA+mqttGGT1QHEad/yi
         FVL/J7cJwUGENQhB5wE9JMF/rynmmJptf5OEwSccYs1FE0lHm6BPmmMnsYNpxIH4BQm4
         Vnqqv3dXi9ZOMsyHGOqEBXm8BF6aN8+ZaNwzGt4LYZlFt7BguS8vwtfPaTRUdy+cwyB6
         VlSg==
X-Gm-Message-State: APjAAAVaLQMJXNpMiStVZSB9co5TuOyQ/aUkVGiT9cXsUIbgXGpbtsJP
        zO0Qviwl7NIbrnDvVKEMFKoZ6Q==
X-Google-Smtp-Source: APXvYqyvcfVGNOGMK+GZbb7AZqNZCVjS9j6kjjivsM+QlsoZ2vEDj70m8h4QmgUxsDxZt9+Op2eLlg==
X-Received: by 2002:a05:660c:12ce:: with SMTP id k14mr3743232itd.23.1555601348493;
        Thu, 18 Apr 2019 08:29:08 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id p17sm790420iol.69.2019.04.18.08.29.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 08:29:07 -0700 (PDT)
Date:   Thu, 18 Apr 2019 09:29:02 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <groeck@google.com>, linux-usb@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
Message-ID: <20190418152902.GA185502@google.com>
References: <20190418065141.GB12503@kroah.com>
 <Pine.LNX.4.44L0.1904181011020.1513-100000@iolanthe.rowland.org>
 <20190418143048.GA11555@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418143048.GA11555@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:30:48PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2019 at 10:21:32AM -0400, Alan Stern wrote:
> > On Thu, 18 Apr 2019, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Apr 17, 2019 at 04:20:09PM -0700, Guenter Roeck wrote:
> > > > On Wed, Apr 17, 2019 at 3:41 PM Raul Rangel <rrangel@chromium.org> wrote:
> > > > >
> > > > > On Wed, Apr 17, 2019 at 03:23:52PM -0700, Guenter Roeck wrote:
> > > > > > On Wed, Apr 17, 2019 at 3:11 PM Raul Rangel <rrangel@chromium.org> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
> > > > > > > >
> > > > > > > > This sounds like a golden opportunity!  Submit a separate patch making
> > > > > > > > the parameter to kobject_uevent_env be const (actually const char *
> > > > > > > > const []), then submit this patch on top of that one.
> > > > > > > So there are other parts of the code base that dynamically create their
> > > > > > > array values. So by making the function take const, it breaks :(
> > > > > >
> > > > > > Confused. The calling code can still be non-const. I don't see the
> > > > > > parameter modified in kobject_uevent_env(), so declaring it const
> > > > > > should be possible. Can you give an example of code that no longer
> > > > > > works ?
> > > > > static int notify_user_space(struct thermal_zone_device *tz, int trip)
> > > > > {
> > > > >         char *thermal_prop[5];
> > > > >         int i;
> > > > >
> > > > >         mutex_lock(&tz->lock);
> > > > >         thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
> > > > >         thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
> > > > >         thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
> > > > >         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
> > > > >         thermal_prop[4] = NULL;
> > > > >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> > > > >         for (i = 0; i < 4; ++i)
> > > > >                 kfree(thermal_prop[i]);
> > > > >         mutex_unlock(&tz->lock);
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > drivers/thermal/user_space.c:48:52: error: passing 'char *[5]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > > > >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> > > > >                                                           ^~~~~~~~~~~~
> > > > > include/linux/kobject.h:238:22: note: passing argument to parameter 'envp' here
> > > > >                         const char *const envp[]);
> > > > >                                           ^
> > > > >
> > > > > http://c-faq.com/ansi/constmismatch.html explains why it fails.
> > > > >
> > > > Interesting. One never stops learning. So the best you could do would
> > > > be char * const envp[], but I guess that doesn't help much.
> > > 
> > > Yeah, I went down this path a year or so ago and had to give it up as
> > > well :(
> > 
> > Well, the signature could still be changed as Guenter suggests.
> > 
> > And the array being added in the new code could still be static.  
> > After all, there isn't really any danger that the contents of those
> > strings will be modified, right?  It's just that the const modifiers
> > weren't put in until it was too late and there were too many existing
> > callers.  Perhaps a comment about this could be included in the 
> > kerneldoc for kobject_uevent_env.
> 
> I am all for changing this, but I remember I tried to, and somehow
> failed, but I don't remember the full details sorry, it was a while ago.
> If someone figures out how to make this all const, I will gladly take
> that patch.
> 
Well we could use varargs...
int kobject_uevent_env(struct kobject *kobj,
		       enum kobject_action action,
		       ...);

This will accept both const char* and char *.

Example https://repl.it/@RaulRangel/Const-char-var-args

It seems like most callers have a fixed number of env params, so you
wouldn't need a function that takes a list.

> thanks,
> 
> greg k-h
