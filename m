Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E4321852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfDEOf0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:35:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44100 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:35:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id d11so5704038edp.11;
        Fri, 05 Apr 2019 07:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnXIp9kl0uwPAFOoOmmi0qdoNycq5REFbvqdpS2BpVQ=;
        b=JMJ+h0TgjfwMvPimmlWfenguELzrVBL8X8cMIGV0o2h93YgK9rx1Nni7cK7mvOwzQN
         jH8Qx8m+uy1hsQR0EGYnU9uxnPuU7UuEDSeaFyzswtDkh0h5ZvLcP6Z5msiEMLK15SlY
         XEf0VjuQi4ZBYBPTrlHX0JmdYqPn1jR7wTQP5X+Rwa09iP4EFHF5VrWzl7Pe+YiZlELr
         ucGXnbPWc3ySbLTy5h59hxXPUbce40Kt+Yiq3+3q/GUdebFw7kPF+jjJZfP7jQ3AJfPO
         tVwvU7nYVWaE4USC2dt+F1u3YYLdWvDy8cSS8/xjd/SXVz2wa3PpEWVrjZKh93cDkd6s
         1fXQ==
X-Gm-Message-State: APjAAAUfkE2SVaFoYJSKJ96MMPmzdqWZD58bGUSQDcRDnhHuibQkM0wI
        v2doamNaQyF78raDDOuSvxaQETcj7Ro=
X-Google-Smtp-Source: APXvYqzDM4++3WRkxz1h28QOImxB5kVrX24Yz+G6i9LpoPHuLNeWX0vajh5qB5AUAEWvqJC6okjBxA==
X-Received: by 2002:a05:6402:383:: with SMTP id o3mr8342761edv.173.1554474923412;
        Fri, 05 Apr 2019 07:35:23 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id l42sm6609468eda.60.2019.04.05.07.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 07:35:22 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id r4so8302369wrq.8;
        Fri, 05 Apr 2019 07:35:22 -0700 (PDT)
X-Received: by 2002:a5d:6646:: with SMTP id f6mr8389140wrw.68.1554474921893;
 Fri, 05 Apr 2019 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190404135736.8491-1-peron.clem@gmail.com> <20190404135736.8491-2-peron.clem@gmail.com>
 <20190405090236.e7vnyjzxmzfke3d6@flea>
In-Reply-To: <20190405090236.e7vnyjzxmzfke3d6@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Apr 2019 22:35:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
Message-ID: <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 5:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 04, 2019 at 03:57:36PM +0200, Clément Péron wrote:
> > Allwinner H6 has a watchog compatible with A31.
> >
> > Declare it in the device tree.
> >
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
>
> Applied both, thanks!
> Maxime

IIRC there are 3 watchdogs on the H6. One is the trusted watchdog,
which should be reserved for underlying firmware.

The other two are the normal and R-block watchdog. Although they
look the same, the "normal" one can't reset the system. :(
That one is actually the one ATF currently uses. So reboot doesn't
work on the H6.

ChenYu
