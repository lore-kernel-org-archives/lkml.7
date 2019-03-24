Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CADC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE032080F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUy8S7N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfCXDs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:48:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33775 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXDsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:48:25 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so4943164iog.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=suYO+eoQ2grJDTXnppsgX+kgr72VZ9qdXSEJQCTe8HQ=;
        b=iUy8S7N8WeU99XqZtiMXz79XkZA+G895kbx1lwZF9BALsxzd083z/scGrFlyWgg+Ku
         6t2bd0X8ghpL7IQUzUjzZRQl1Yj8eurD1FmFnBuiioKR/Q7TR7FfX1MV2wtx9tOhNoev
         cCf58D+sfAuWzGulgRPESWX+mo/EnJhHCXbcNzNLl5MAxQhEWBGdySF9rPPYd8CEF56r
         66VEgc55l7YU61oDn2i1vGzBPsrzX3yNEhWhNdicy/HvoWtYNrhFlhJEUw1SiYbf7PDD
         V++geD9SfwPy8YrOmWoy6+d8r90AmPjpmmWFRFgiC2oRyw+gBUoJZQedq80DxaX3BMe7
         1LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=suYO+eoQ2grJDTXnppsgX+kgr72VZ9qdXSEJQCTe8HQ=;
        b=dc77jYy5enD2NPHbDYCpZztwP4VFqOqg82aPZZydxWTqO457YX/En+kW9mc54gNHU4
         ilEvwOpWOKH/7Qrje1LMmCPtJX0fW3cChHacABoWCs+oI6I0r9GDHyt02mTe+9NVszvu
         +Q/6iqSpEgZ9NcXFU/iLZCN7/XdKfr9hoTPKL8sUIw8I3QTU3lzx8Jcdu8i0kj/dhm7p
         Bhu5diDvFHQD++nGUk/5UQKlQ/xpfPsGthNEqKIwX5tTVbDPq2I9+en23tACJhdf0YjR
         xcOLk86xOYj+OqT9raYAg9dIgTmsWIHi6E0fnrG7b9xa3aVeHG1osKbeSRnWmCsFqCwo
         uGmA==
X-Gm-Message-State: APjAAAUsIsljwVcgfkrgfnzuZ8iSKlN8UIlbHTTk9agmQWyVnnYA4aYo
        r4yDfF/dcOmzeoFHec5c+3JsrIiH
X-Google-Smtp-Source: APXvYqxd+fi/8fcPZoiP/FARIPuhsc/JAn4bRPDfXc9dL++snYkeIeYiEbCo4Jrr/5rf4wtzjPYUOg==
X-Received: by 2002:a6b:e509:: with SMTP id y9mr12213729ioc.169.1553399304655;
        Sat, 23 Mar 2019 20:48:24 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id y101sm3814728ita.25.2019.03.23.20.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 20:48:23 -0700 (PDT)
Date:   Sat, 23 Mar 2019 23:48:21 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Add support for default attribute groups to
 kobj_type
Message-ID: <20190324034821.GA47676@ubu-Virtual-Machine>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <20190323060737.GA28563@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190323060737.GA28563@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 07:07:37AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 22, 2019 at 04:14:40PM -0400, Kimberly Brown wrote:
> > kobj_type currently uses a list of individual attributes to store
> > default attributes. Attribute groups are more flexible than a list of
> > attributes because groups provide support for attribute visibility. So,
> > add support for default attribute groups to kobj_type.
> > 
> > In future patches, the existing uses of kobj_type’s attribute list will
> > be converted to attribute groups. When that is complete, kobj_type’s
> > attribute list, “default_attrs”, will be removed.
> > 
> > Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> > ---
> >  include/linux/kobject.h |  3 ++-
> >  lib/kobject.c           | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> Yes!  Thanks for doing this.
> 
> But how did you test it?  Did you convert any kobj_type structures to
> the attribute group and see that all was the same?  Ideally I'd like to
> take this patch with at least one subsystem that uses the change,
> otherwise this looks like unused code in the kernel.

Yes, I tested it by converting a couple of kobj_type structures,
including one that I recently added an is_visible() function to
(vmbus_chan_ktype in the hv_vmbus driver).

I'll put together a patchset with this patch and at least one
subsystem's changes.

Thanks,
Kim

> 
> thanks,
> 
> greg k-h
