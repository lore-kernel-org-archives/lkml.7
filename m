Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B442CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4B1222CD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ITWCWJ6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfIZR5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:57:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38554 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfIZR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:57:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id w10so1620431plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=ra0dRLmfBUCQGsQcf5szx3nA8oNPLH7wPDml/wV7DqY=;
        b=ITWCWJ6tqqC/ZM6OD9WMIZrbkglthcrix2GG/LvDieJySeSgiWaMpmSOK0xrK0xm06
         ec/m3uHU3SiUEhT7eLUdfGbI+DN0LGfNi7tQZLu57ErbujONFpP5E7CgaHBIpk9LHwI2
         kE3YEzpDK7fVmwCp2OioRnV1nH8yPX5cDgrl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=ra0dRLmfBUCQGsQcf5szx3nA8oNPLH7wPDml/wV7DqY=;
        b=n/6g6Si+KiTwtkDpBfOZBdft1EBdmqGdhFkkde1PBEldfpkRXxvijD9InuHM9ul+qT
         JphHPjrFxEmKjAxw3HbeUpnvYB2GcsivA8CPd/66q4bsq+XysJSxHS/nKNLrubabge79
         p37MLM0nYb9jkVm4ev9iYGLvbv8s2i45uVdp8ujUz8T1/o4HiMBMFsbCk6huQ0CWpWhg
         8I/AULYiEr4ha/b1if3hbN3oVp4fCdfpG384iM9wyFlG958hS7dXr8oDx3WR1PbhwK+s
         vTHOwa/bDwDP421NawHq11MCB8zeVVpwWaMBRIpX5tcTmqoidwJM7T8WDMEhIkkPSSv+
         dzzA==
X-Gm-Message-State: APjAAAWW9f2Bw2GnkSEHx9eArFStPUFz9QQ7xF+VXzkxtbxISUpDYvCC
        B73thTiluKqJOycgu9rQlQWDgQ==
X-Google-Smtp-Source: APXvYqyTHTzIf5yWzfKy0xKUYeZGydmLqbbwvrZWLYFx88GbwFOpdeI3cVq+oqoSkggF2QPJ0+vifA==
X-Received: by 2002:a17:902:7605:: with SMTP id k5mr5346435pll.304.1569520659918;
        Thu, 26 Sep 2019 10:57:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n66sm5128141pfn.90.2019.09.26.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:57:39 -0700 (PDT)
Message-ID: <5d8cfc13.1c69fb81.73236.ab28@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOCk7NoNX7+fxCYNOCMVCv1_-X3ZbaHwFjzWjMp6VKL6ZoroLA@mail.gmail.com>
References: <20190912091019.5334-1-srinivas.kandagatla@linaro.org> <5d7fe5d1.1c69fb81.eca3b.1121@mx.google.com> <CAOCk7NoNX7+fxCYNOCMVCv1_-X3ZbaHwFjzWjMp6VKL6ZoroLA@mail.gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] soc: qcom: socinfo: add missing soc_id sysfs entry
User-Agent: alot/0.8.1
Date:   Thu, 26 Sep 2019 10:57:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-09-24 20:54:41)
> On Mon, Sep 16, 2019 at 3:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Srinivas Kandagatla (2019-09-12 02:10:19)
> > > looks like SoC ID is not exported to sysfs for some reason.
> > > This patch adds it!
> > >
> > > This is mostly used by userspace libraries like SNPE.
> >
> > What is SNPE?
>=20
> Snapdragon Neural Processing Engine.  Pronounced "snap-e".  Its
> basically the framework someone goes through to run a neural network
> on a Qualcomm mobile SoC.  SNPE can utilize various hardware resources
> such as the applications CPU, GPU, and dedicated compute resources
> such as a NSP, if available.  Its been around for over a year, and
> much more information can be found by just doing a simple search since
> SNPE is pretty much a unique search term currently.

I wouldn't mind if it was still spelled out instead of just as an
acronym. Who knows, a few years from now it may not be a unique acronym
and then taking the extra few seconds to write it out once would have
saved future effort.

