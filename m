Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA42C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BE2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jD2XRByB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfGVSSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:18:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37661 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbfGVSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:18:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so7309583pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=bdmEyD1tHGaxY1ZlrNXktYNbDBoxT67t89iQedYViU4=;
        b=jD2XRByB77jpz8oESlV2M8e2YqHA5OWvaY91DBJGZvAV4PUjKf0YAHrFyemyl1HZci
         ZeR+SwU0zsOjunrxl82QuMicKE2IeCYMTuXzYubRB+ZpDsmnnH4cfbM9KX3lLytNKX5l
         HWxcBaH3SKmXPuHrKGHwHLia2CN/JsZteix6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=bdmEyD1tHGaxY1ZlrNXktYNbDBoxT67t89iQedYViU4=;
        b=Nx66zHeCoIiM383w7uoGcPMs2rzT9uMSQ30nVZPRa3RkrRaUKAdnX4nq8cAzvrh3KF
         WwPS0TDrQJpsQgOWZ3rSerFBRqN46Du+GnUQZHizd9PSYNhO5zFjPjNIFGs6+1FL2cGB
         x6FVjg1WVkBJqaJty7yegb/nuyk7DkwSB4K3PSKj5p8MN93EhnXRoA4rrVTjxMZnZxyo
         0px5/4S0ufE2Yo5UYhjOmhouHUp9G5nPdhuqtqDimYoApLgDZpSLDX7gV8qcFLYxquD9
         8epJMUopldb0dVf2L0h+j9V/JjWPCUUvLbo2P6qY/RE50KJyU7zDgRwaTnW2K/bDJ/pU
         ++5A==
X-Gm-Message-State: APjAAAVoEFnCtPCSPH7MRMGSO8whgugx0Xz4aIPcGB73LgB3btjH87Dn
        d7uDmb/2moHwICmVtKoqDcpi2A==
X-Google-Smtp-Source: APXvYqw1WCTEtPf/4QpZct5Z+fOYeJwNzW8DbpFLtGpuiaWS9d42/M5FHd2yC7A0VCS35fsC46+fHQ==
X-Received: by 2002:aa7:9a8a:: with SMTP id w10mr1513108pfi.66.1563819516250;
        Mon, 22 Jul 2019 11:18:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j1sm66969694pgl.12.2019.07.22.11.18.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:18:35 -0700 (PDT)
Message-ID: <5d35fdfb.1c69fb81.5fafa.aaa9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722162003.GG25567@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org> <5d3209e7.1c69fb81.5ef1.5195@mx.google.com> <20190722162003.GG25567@codeaurora.org>
Subject: Re: [PATCH 1/2] drivers: qcom: rpmh-rsc: simplify TCS locking
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 11:18:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-07-22 09:20:03)
> On Fri, Jul 19 2019 at 12:20 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-07-01 08:29:06)
> >> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> >>
> >> tcs->lock was introduced to serialize access with in TCS group. But
> >> even without tcs->lock, drv->lock is serving the same purpose. So
> >> use a single drv->lock.
> >
> >Isn't the downside now that we're going to be serializing access to the
> >different TCSes when two are being written in parallel or waited on? I
> >thought that was the whole point of splitting the lock into a TCS lock
> >and a general "driver" lock that protects the global driver state vs.
> >the specific TCS state.
> >
> Yes but we were holding the drv->lock as well as tcs->lock for the most
> critical of the path anyways (writing to TCS). The added complexity
> doesn't seem to help reduce the latency that it expected to reduce.

Ok. That sort of information should be in the commit text to explain why
it's not helping with reducing the latency or throughput of the API.

