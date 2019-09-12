Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE8C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3045920830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="DZxZImvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfILKTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:19:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43329 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbfILKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:19:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id c19so23399997edy.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rCJRuZodeCpPu+MIWRS27Ed/gzyJWJ/AkAs4o6Nd360=;
        b=DZxZImvWh3/RaN4AE3pN9IM+EaDq95bEB9WKbkEUjtsK68dv6CAittKvOAjmVXq1uS
         0OZ3gtdUzDlb0Yr4tN+3XTchD0LNxJmcHw+aFBqDAl5XwtAybbIeSXgK8m78mU1PBxTw
         RQ1W9kHzXirW6bxcfLufD4asM8wXrxRbXacABxnXNZx2YRPCi1bzPC+/2YDgiCPB33Mj
         IZo2CGwdJ5+jAhn6EiNPcahRC07NDk9cZdKOt+rQ+p/x/flkFP3Udw6kaQzWShttlEDy
         6na3vsWlZYukZ/+8JnNgpnI6xpUypqml0rexPDn4IuxD9l2mNZffU6ImTZw6LRIDHOBF
         2+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rCJRuZodeCpPu+MIWRS27Ed/gzyJWJ/AkAs4o6Nd360=;
        b=L0uYRLxytt9+u9DHrxeLsMNNVXYiT0W5T/GQN76CFoauo3LvMit5SOTgjOam5kFe9E
         6kZXSxadSlzxHKlglFkGoRSkNoH2KgayC5se6ut3aQ83w85UAlfLZYmaNO2vBdVowshZ
         8uvH/y8MRfnG9aX7uppK+1rK0PS+xzHgkO78hULJTXb7fwK1Oh9n0QNcCIy8kBrUEpcC
         ZvsZlrd/8JnHRB///xONYcKIq4HmS9JnOhY0Mh30W+ujq/wKYyDBsarSgdV2SA6ms5IK
         SUSLyCWC9rxcaVbyh0ZhO1JFiE4yu0O3wWvd0Npk+Dto5aB3ERn3xEvH1KK2nKFiJ54U
         eF6g==
X-Gm-Message-State: APjAAAWZrMD/zIpxdUQi+eKaJhv6hBkx+orBK7+26UCbsb1bJx7ViO7h
        w6zuN1RfyYmBLlisX7Y01aqwig==
X-Google-Smtp-Source: APXvYqzRa5N5LhGfMTJuJ4oaj2D7z4BUkhWF/2X+DJwj0jTVnO/miJEr2SF9TZOAj1Aw+J5vr4kYmg==
X-Received: by 2002:a17:906:434f:: with SMTP id z15mr9615390ejm.214.1568283556600;
        Thu, 12 Sep 2019 03:19:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q33sm4710068eda.60.2019.09.12.03.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 03:19:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BD73100B4A; Thu, 12 Sep 2019 13:19:17 +0300 (+03)
Date:   Thu, 12 Sep 2019 13:19:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190912101917.mbobjvkxhfttxddd@box>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
 <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
 <20190911200835.GD7834@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911200835.GD7834@swahl-linux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:08:35PM -0500, Steve Wahl wrote:
> Thank you for your time looking into this with me!

With all this explanation the original patch looks sane to me.

But I would like to see more information from this thread in the commit
message and some comments in the code on why it's crucial not to map more
than needed.

I think we also need to make it clear that this is workaround for a broken
hardware: speculative execution must not trigger a halt.

-- 
 Kirill A. Shutemov
