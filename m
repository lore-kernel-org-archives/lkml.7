Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89504C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454E221904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553247969;
	bh=i4/MNnc1Sea+usyPpKw/vkxvIwHz+vkgmpIh97ysm0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HqlefRSI5a1RXjG7V6nkbz5NC+sh0AJP7EPg15hmUIcuLLuUGt0gHmhy+m4x7zOy5
	 CIdxmG1FrzdWXQugWqy4UP70oWxwhBM5KeyQSu3cXhL1l/IbdFCrLthbUy5+wjjakt
	 /fs8M+Hz8JquWngCExXWZAXV0CP22G8+hRfJDrrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfCVJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:46:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34602 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfCVJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:46:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id u12so1267356oiv.1;
        Fri, 22 Mar 2019 02:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4/MNnc1Sea+usyPpKw/vkxvIwHz+vkgmpIh97ysm0E=;
        b=KNQNd6GtdQWTFZa8rhvGcIgWweoOHRpemQsK7c2fH9g20VP2rN37V9eo3YfiI5jdgM
         qmcbtEfp9svUR4fPnwSVbgE47QTBPR73eE3TDDSplttCuA04YrrjU24EtKZOH7JwkUWC
         ew3KsTqAEi3TMIzRyRBYnjfLp45xXnIPE6vmRAHsCZ9i9ZjkXcB123cjPwPXQ5+V22+s
         5wmxw1Uaex1cculPB7iVGiSZ1/B0OT351bTJupaV9zt2sXf4Ewwelz33gc84h239vYaJ
         Ffx20A6STvRO2kxd9Tf8VVY5wq/hSUbwnO2ELAzoPQs2WoylW/aa8xM/Xq/Ob5TlTw7K
         Qv0g==
X-Gm-Message-State: APjAAAX15PitLp45M7k0lebsYVi3TsXjmPfCSH7T5udFBAEdpUNjXMTV
        HsmxdC7kEwHBDTOgg1/v8F1KbLGl8rxKAtV6AnEBWg==
X-Google-Smtp-Source: APXvYqy8qQWkbml8D0MLXmIVayDzaUmem5mHamQOx04tW4evyz61JMOJSNdIvn/+mQGKYiFxOzaRbOdGBgpPXuKeU8Q=
X-Received: by 2002:aca:6046:: with SMTP id u67mr1152190oib.84.1553247966744;
 Fri, 22 Mar 2019 02:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com> <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 10:45:55 +0100
Message-ID: <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> Currently, the cpuidle governors (menu /ladder) determine what idle state
> an idling CPU should enter into based on heuristics that depend on the
> idle history on that CPU. Given that no predictive heuristic is perfect,
> there are cases where the governor predicts a shallow idle state, hoping
> that the CPU will be busy soon. However, if no new workload is scheduled
> on that CPU in the near future, the CPU will end up in the shallow state.
>
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-
> core can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.

Isn't the tick stopping avoidance sufficient for that?
