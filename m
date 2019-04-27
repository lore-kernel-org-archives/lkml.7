Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CE7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7C2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPO+ptpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfD0GTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:19:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40884 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0GTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:19:00 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so1632740itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AA/ZawmM0902rvXQ1ebDm2YuQrKe3V70foLmoIoE4Qo=;
        b=PPO+ptpKPEIc/QKQQ8wbAvzTOsgYAKoKk8j57oAGbJSe5X0aDdzRMOk1342AY74flX
         ehkF7FkYN79mu1QAuCXXtk3QoylgzyxLlsp3wX/IJBEcRKxr2wJS2qpzXK4dfG/rEUxt
         st+O9EBVBRVCdZPXE2HklEvTAdOdW8GjZRUiUFy4WfkFnWlzVlWf8lWN453t7hrT9H5m
         6FjiGqJ+0aI7gHI7n7bzKlvh63g87Njy0MnSdOgjykLCllHa1jiUuxpJb74qsnyM7Fc2
         hGfZ2KyZ5uGgTXpDav5L6iLiKzPVNgXl0OjyTD2B/msRn7sw+wt0XicwvZyxmcmO7EaI
         vWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AA/ZawmM0902rvXQ1ebDm2YuQrKe3V70foLmoIoE4Qo=;
        b=GrelO+kdVpbc4CevRlH643K7j6pSkm5QOqw3UZdpHMsN7PbpyjAKbvTNiiqtZWK9ep
         Bl+9ayZw5J9M56YENt87VmKP3GCL6DpJwPFncReP7l/8iwmKj13YngPAlW3EMk/EdSIs
         zIeziwCICvD2F0UKNh5Y27bSBH6v77hBB7POQ3hej6FT/92JxVpGyWQVWt1dBYdvPj0X
         xhfVBT3JXbOX8fHGnD84nO3JxZ9AFVxVgXx397rtRN3p0AOKDzfen0MJU1FensFv5UR6
         /d7bygu8qTeh4n1U3LmL871kiRrxTn4FPAvLRVbynR3F/ktksvqy78C1dCjHYvXpNlUf
         mhsg==
X-Gm-Message-State: APjAAAXJZvioJZ70Pqwgqx3Va1mMYUTmchVpZP1MfXsKiDeXiTsyz8Zz
        viQXsz4sEMghzOQ/bE0UqaA=
X-Google-Smtp-Source: APXvYqw5w2uRqCF5/U4cdEmMQud5uaF4UwfiIS9TrPZ5LkeSqgHt/81k79VijwZS7XTil+2EPiltPg==
X-Received: by 2002:a24:b214:: with SMTP id u20mr3465165ite.134.1556345939834;
        Fri, 26 Apr 2019 23:18:59 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-b1d9-7ff0-b1de-5362.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:b1d9:7ff0:b1de:5362])
        by smtp.gmail.com with ESMTPSA id o2sm1042061ioh.59.2019.04.26.23.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 23:18:59 -0700 (PDT)
Date:   Sat, 27 Apr 2019 02:18:56 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kobject: Add default group support to kobj_type
 and replace subsystem uses
Message-ID: <20190427061856.GA675@ubu>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
 <20190425201253.GA12131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425201253.GA12131@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:12:53PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 01, 2019 at 10:51:10PM -0400, Kimberly Brown wrote:
> > This patchset adds support for default attribute groups to kobj_type.
> > Also, the uses of kobj_type's default_attrs field are replaced with
> > default_groups in the following subsystems:
> >  - samples
> >  - block
> >  - net
> >  - irq
> >  - padata
> >  - cpufreq
> >  - livepatch
> > 
> > The subsystem maintainers and lists will be copied on the subsystem
> > patches.
> > 
> > The uses of kobj_type's default_attrs field in the other subsystems will
> > be replaced in future patchsets.
> 
> Thanks for all of these, now queued up.  Patches to fix up the other
> subsystems are always welcome :)
> 
> greg k-h

Thanks, Greg! I'll start preparing more patches.

I know that patches should be in linux-next for some time before the
merge window opens. How long do they typically need to be in linux-next?
I'm trying to figure out if the next patches I work on could be included
in the next merge window, in which case I'll let the maintainers know
that the patch will either need to go through the driver-core tree or
wait for the next release cycle.

Thanks,
Kim
