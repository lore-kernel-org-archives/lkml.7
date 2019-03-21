Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53BC2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553137781;
	bh=RjlNB18UXRrad4OnAmDpyXn2KOrgSxRo/jLmp+a0FTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jygzamv9eWRWJxxYgL5ki/D6LFq74GAGQTys6nAHYtmzVTB+ylIT3nS0B+FA5CWtf
	 0UgwNZ4iRp+euvM1pQBGvCnJUXKp7S6NIruO0jo9AhgN92U3+ZKMB60JOmLEg+bHLm
	 csEVQ0/sk3U3py1PzIzkrDseQtfxyz/nmh613eZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCUDJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:09:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42046 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfCUDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:09:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id j89so3766215edb.9;
        Wed, 20 Mar 2019 20:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjlNB18UXRrad4OnAmDpyXn2KOrgSxRo/jLmp+a0FTA=;
        b=uDEM4J4s1sUmvxr8IObTYcclP23Dxzmd+Yl8fBXImTqGQ1dsurADPVjCSkdgBVfEEj
         m4d+kteqAV5DpFFhnGCN0e6upj5ixt1kPwwW0tt5/iOas9YWBZQgsE6dFJQezObtHS1h
         INkpnrSzR7nHWvG3TLLeNYzjvT30pgTWJFC/Pb6Z2f3zeLkv7EwTdFuJa9nn9he4SfWw
         TWXh578WMMKDbEhyW+B9QgN4aeiy80TbybSaDZudMMGdksrXdlDJONOBfsdMV9h456P4
         SEyfbfJCJSJ+apgihsSLeXq2sJD/TfKqs4NPCh1Ybev/+IYxX2yKJSPt3RiDJHKq+12j
         ZDCQ==
X-Gm-Message-State: APjAAAU8nLKGPV548z2rp7H060IKSV0Men+0ENEYBolRD/3M3vtaFA/w
        4ldPdX5rCpXUQrFJDX0d4wG4zjIQ6ZYAMhECZCg=
X-Google-Smtp-Source: APXvYqxDqCv3I3QUGI1JcSs/9+ND+jVypxzPiwK/psRtUcxShhQ8rLy6om9a+o5o25iYZDZlQx3jWRTJ+E3fVPruy2o=
X-Received: by 2002:a17:906:6ad7:: with SMTP id q23mr818713ejs.210.1553137778511;
 Wed, 20 Mar 2019 20:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
 <20180817163442.10065-3-calvin.walton@kepstin.ca> <CAJvTdKmXSQyY-Jdv7OkseHEE-76oDPLeJ8v8ShApDRKqWsukSQ@mail.gmail.com>
 <d45d021c5546a301cf1c53d6b6d8c83ebd802a57.camel@kepstin.ca>
In-Reply-To: <d45d021c5546a301cf1c53d6b6d8c83ebd802a57.camel@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 20 Mar 2019 23:09:26 -0400
Message-ID: <CAJvTdKkCeVWQu8eCBf5wLV7==z_A4LctgayEN+7+tFjyd3LBLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package
 power on AMD F17h (Zen)
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (I previously wrote that this would be easier to test with the patch
> applied, because the package power is reported with the -Dump option,
> but I'm not sure that's actually the case - the value might still only
> be collected once per package?)

Right -- we'd have to move it to a per-core or per-CPU data structure
to capture it on a finer granularity than per package.

Of course, if you want to see if you get different values on the cpus,
you can always dump the raw values from each cpu using rdmsr(1).

Unfortunately, I don't have that AMD hardware -- somebody with an
interest in it can test it out.

thanks,
Len Brown, Intel Open Source Technology Center
