Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33FC010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F2020869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2PWqy75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfKELHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:07:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKELHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:07:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id c17so13031721wmk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uam4yKu+WYMYJ5RphtXQPnJhDtJ0Zqcujz3CXjflWDU=;
        b=N2PWqy75qroW7rjtdCd7EbvB8HjCMOXP4R1oSiKbld5G5Phcr60+yg2bTxMNak1xZO
         c5+RtQmueIxYccx7JAR1yUKT7iWNsJ8SpsHJFmJPjPbjZZ2yuUM9zT9/Q+sQ98rjFbJO
         SUZ8oWlnA3iSexOQs6YPCF1UhNHiaSA+4+epU8Vg/pkIIbIlCCzBAZOizXboTm4dJXR1
         Cx4YKAbX3P06S66yJDRqzoTfj/P4Z2cGPXdvXeXOo+VkgFYb+FBlP6qFk8cZY9PDRZY0
         0A3iYAC5dDVSWG3rhfeiDBh2F3MW//taouRqrhPgq8TIfyUQPjnFddNkeW6zFuTh5MdQ
         Xchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uam4yKu+WYMYJ5RphtXQPnJhDtJ0Zqcujz3CXjflWDU=;
        b=CWnhmgAVKu0mflmSKeVSUZPgHBp1T7ZBDvlUogMu5AflROV35vhNHVif0H1m8Ou9ne
         tiZq9EpTKMtwQjdfgGTNRlPZIM1NUWoPmWy5q44nsCLDpBMmPmzWHOvMhWWJ0LmaCdHd
         z9Cbsl+wwx5JAEVTENt9ilQR1Lrg4SbpAipIXlQOYadQ7fO002ok952+ului5mLKdQ/V
         m7kNgVXpTd2VB7761x8P2T6be2bQq2X1cdl8nV1X42sXnJ6NB9cly+gJcfCnKR/5bk1s
         tg0hL8lojrbluDvx+EgTmVTEG0DBZ3/kHCYqGSyz6ePgGHxqccnYjSwwA8dbFx4tddqe
         YdpQ==
X-Gm-Message-State: APjAAAVF+6GfN3p5pSUOcVSl0nN0woqlIEgBuiMn/VU6DSw1XjO5X1ge
        1Vd90N5HQFkHU6MDKM8TKqtbVmPKkB10aQM=
X-Google-Smtp-Source: APXvYqw07SweJiA+wmBvy9KuSsYO7d3T2F5giEmdTAkNnnNXyV8vSgNHJndUZr0/FWpS+E/uzHi+5A==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr3479875wme.98.1572952059211;
        Tue, 05 Nov 2019 03:07:39 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.gmail.com with ESMTPSA id b17sm11175395wru.36.2019.11.05.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:07:38 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Tue, 5 Nov 2019 11:07:37 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: Re: [PATCH v2] staging: comedi: rewrite macro function with GNU
 extension typeof
In-Reply-To: <20191104164653.GA2281588@kroah.com>
Message-ID: <alpine.LFD.2.21.1911051106520.11074@ninjahub.org>
References: <20191104163331.68173-1-jbi.octave@gmail.com> <20191104164653.GA2281588@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Nov 2019, Greg KH wrote:

> On Mon, Nov 04, 2019 at 04:33:31PM +0000, Jules Irenge wrote:
> > Rewrite macro function with the GNU extension typeof
> > to remove a possible side-effects of MACRO argument reuse "x".
> >  - Problem could rise if arguments have different types
> > and different use though.
> 
> You can not just get away with a potential problem by documenting it :)
> 
> You might have just broken this.  Why are you trying to "fix" something
> that is not broken?
> 
> What is wrong with the code as-is?
> 
> thanks,
> 
> greg k-h
> 
Again I made a lot of mistake. I will be more carefull.
Thanks for the feedback
