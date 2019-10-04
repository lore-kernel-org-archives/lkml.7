Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C7C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 05:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18F21848
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 05:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJyVp4pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfJDFvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 01:51:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44076 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbfJDFvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 01:51:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so3092361pgt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=unJ1v6HVKxuDiPc/aS201QU9G4bHdnBp/CHw6DE6gKk=;
        b=rJyVp4pRytBy0bcdhLCHyuZczSU3u3NXL75qLt2S963EyjEQ1ZMcT8MJAa6qWY2nDI
         HluMh/daIYQuIRVBhTAGrJcsSGiwPLHju1/+GPKnDxCJGnadJK2rfgDKt2qf9qHypvk0
         xw3o1TADQ5k7Jn365mGwDTlLxyhnF8I3afLp9BfV3VAe5rbSIQjk3phhVVmN2LdZktcQ
         fPeIPaximdKA/5SI+l1HJfevuqsMdgOueH+bJQ/KzTHSxXJDmpewLTsWAwrr9ZA/guuQ
         /j1FBHdNKs6h/uClA9iAzNIQCBlshZonQBpz218FHo2t/IrP7WMFwXQNjorwuzVL0W4v
         CVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=unJ1v6HVKxuDiPc/aS201QU9G4bHdnBp/CHw6DE6gKk=;
        b=BBUa6iXP5N66siBj2h0wRnivfBkL9eoivJEQ2yPd4fabrbJS9M7Sj+ppFagoOkNkuI
         CrhkloOKoeP+NAYluBstVKWWzNS8lCoUBoF/KraUrQhrvUm/zWPfTDuLz1m8HhndghC+
         5BzTTbD5Nh7S+bynCO2ysk81PlQKKey9lx4abJ0KQhdqANwWcJpEZGWeRbegXqCrgG3d
         aUAkr5oHC0nrK+k851jzn/aHNZb2iEUgjFtXpbvXovbEZnX4WP/kL0bS7TESl20Cn1rQ
         NjCVt3YbL847kYZACUxYTPEjoiOdJdQbKIVQh4TsxvO8g2AMhiRwi6vCm6Y/esPzoz7s
         4EPg==
X-Gm-Message-State: APjAAAWnyutA668eUrL3GcLyq0gnUGNUocge3+j8XN8wZeyAhQpGTGnC
        HV39Dv5P4oi5qfNN5fGzDW3WZg==
X-Google-Smtp-Source: APXvYqwHr6jPi9lKuz1Q2laCdggCEKW3g9g+9aQYxeAS32OyaqviYwJ54MsS3rwS7Cvd/XDdDIpSww==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr15107769pjb.74.1570168260323;
        Thu, 03 Oct 2019 22:51:00 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8sm5111262pfo.64.2019.10.03.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 22:50:59 -0700 (PDT)
Date:   Thu, 3 Oct 2019 22:50:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Murali Nalajala <mnalajal@codeaurora.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] base: soc: Handle custom soc information sysfs entries
Message-ID: <20191004055057.GH63675@minitux>
References: <1570146710-13503-1-git-send-email-mnalajal@codeaurora.org>
 <5d96daca.1c69fb81.fe5e4.e623@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96daca.1c69fb81.fe5e4.e623@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Oct 22:38 PDT 2019, Stephen Boyd wrote:

> Quoting Murali Nalajala (2019-10-03 16:51:50)
> > @@ -151,14 +156,16 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
> >  
> >         ret = device_register(&soc_dev->dev);
> >         if (ret)
> > -               goto out3;
> > +               goto out4;
> >  
> >         return soc_dev;
> >  
> > -out3:
> > +out4:
> >         ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
> >         put_device(&soc_dev->dev);
> >         soc_dev = NULL;
> > +out3:
> > +       kfree(soc_attr_groups);
> 
> This code is tricky. put_device(&soc_dev->dev) will call soc_release()
> so we set soc_dev to NULL before calling kfree() on the error path. This
> way we don't doubly free a pointer that the release function will take
> care of. I wonder if the release function could free the ida as well,
> and then we could just make the device_register() failure path call
> put_device() and return ERR_PTR(ret) directly. Then the error path is
> simpler because we can avoid changing two pointers to NULL to avoid the
> double free twice. Or just inline the ida remove and put_device() call
> in the if and then goto out1 to consolidate the error pointer
> conversion.
> 

But if we instead allocates the ida before the soc_dev, wouldn't the
error path be something like?:

foo:
	put_device(&soc_dev->dev);
bar:
	ida_simple_remove(&soc_ida, soc_num);
	return err;


I think we still need two exit paths from soc_device_register()
regardless of moving the ida_simple_remove() into the release, but we
could drop it from the unregister(). So not sure if this is cleaner...

Regards,
Bjorn

> >  out2:
> >         kfree(soc_dev);
> >  out1:
