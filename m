Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD9DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F343D21D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa/nkw6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfJKJYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:24:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53033 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJKJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:24:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so9663675wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-description:content-disposition:in-reply-to:user-agent;
        bh=WIjp9+j6LMVkQvyGCF2ejoVmRubycC08K6/Baf6C9Nk=;
        b=Wa/nkw6VJ3P3BW3d2/u7Yk+ZPRQ38ORiG9lld+ALso5woTyJoBcwkSzdtNRwREbDqZ
         yFcu7hVw8Gk0v9GxrGwlJw9/hQQ8i0Lgz2lqCV/Sz+UHGTtKeFIkyVjUeTb8mKG9F64B
         3In4KVrhpNHxo/Ye/dMjRnBWkFjOsFPi/0qDPGD4sGhbPCk17Zjh4zzWogQ3D6ndROR+
         W5m5npPVn5818D0oAt3LvYiqon17muDpgCTHLuWyWO7xIIncz7LSJrNoJCfQc4bZGh9i
         0FMH4OUFvG4nAl0V3RmjFz+yeiYJEylBt4O5LHGuBc50wCdFpoj0uwh0ugRBFDQj4NlT
         PH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-description:content-disposition
         :in-reply-to:user-agent;
        bh=WIjp9+j6LMVkQvyGCF2ejoVmRubycC08K6/Baf6C9Nk=;
        b=jzLKyJzAeFcSiUptqSm1Z6gPMjyzGI0KMz6HKmlS1kr3ISeuhmDAPcpoxzkBWOoELi
         CddtbOEID3mE/M5qnnGTP2xSCQ8DH2x5GkNv1B7qZNMEAQRtf/BqItacgCeI5obbKndM
         gaVbKiihUN3UN9R6KPVzryaNsg2heaZ9f0XDLVG/Dn2/dtK0xkJs+NlEkfIHRIVhm27B
         9jgAuKYqfa6goFdLdwVJNI2RnrvZVrIMRdjAXrSKjyPj4TywhpeZF5ryT7jul229lGl0
         cH7OdAaJpusmFtQLqCZjTtCXbxZ8hzmJL1i1RfPVN7Cx57XwsBghPl4yuJKZcqLJbVz3
         qd1w==
X-Gm-Message-State: APjAAAWdHGpfcVqHtQzVESkvoaGarv4TBlQ62KQaOKJAvJYFlqRbDCWW
        Yt38RFnRmDa7pD//vYwJPvo=
X-Google-Smtp-Source: APXvYqyaQRZtHFF9tI/xmOcgidoH4mw9ucfAtHWGvRC6GJ2WNL6ZtlWOUdCBInDkBPLxi5UW7kWDWQ==
X-Received: by 2002:a1c:7c0a:: with SMTP id x10mr2471596wmc.48.1570785857217;
        Fri, 11 Oct 2019 02:24:17 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id u83sm14078573wme.0.2019.10.11.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 02:24:16 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:24:11 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove declarations of new typedef in
Message-ID: <20191011092411.GA10328@wambui>
Reply-To: 20191011090100.GA1076760@kroah.com
References: <cover.1570773209.git.wambui.karugax@gmail.com>
 <20191011090100.GA1076760@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: evel@driverdev.osuosl.org,
Content-Disposition: inline
In-Reply-To: <20191011090100.GA1076760@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:01:00AM +0200, Greg KH wrote:
> On Fri, Oct 11, 2019 at 09:02:37AM +0300, Wambui Karuga wrote:
> > This patchset removes various typedef declarations of new data types
> > in drivers/staging/octeon/octeon-stubs.h.
> > The series also changes their old uses with the new declaration
> > format.
> 
> The subject line of this email seems to be lacking something :)
> 
> thanks,
> 
> greg k-h
The ending of this sentence seems to have been cut-off. Sorry!

Thanks.
Wambui Karuga
