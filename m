Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NV8vS0NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCNP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:58:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40020 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCNP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:58:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so4268110pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=SO2qVZCQ0sHoD86dU2fe3ja3UME6r79be+S1UxhQDuU=;
        b=NV8vS0NTxzARF1SPfUo/A74H44nJeZdogUqaH2nbNQc3mZjtmT7qkkhA9LFACv5qfj
         celH3HzNAhjbTR5FQccm2AQFmlDnaBNGu/KSMzJyBAtcttDLrDs1tbAFS0bSeqUhHqRx
         t4AAC6zhTp475axNMHCtJAvwdRTZDSf5ynPmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=SO2qVZCQ0sHoD86dU2fe3ja3UME6r79be+S1UxhQDuU=;
        b=Jntm4UVmNf0Ism/qXNRNaTPPeJNYtEbXSDfUjnejfIaR8fbX33IzS9GFSvEoEQBOdI
         VpZ/Nvqo1fs2VPXlzjZ6aIDESpMnFXeyHHrqeHEEkznOQ7ZL2Pcj9oXRhOYDNUq9PRRq
         qB0NVsmaNgJZCPcHGJf1s8QWSY1XoCsQGPyqkhwQycv3q9ie+f51tTWjrr/xMm0MmQM5
         Q4HC6+duA+ofVhGpdY3F3A8WDC/8M2OGQ95PEVDUrYeqWT2LVDcs4ksGwbHZKS+RQCdF
         FS72Oj9Irxmrx6xpUra58ITpknl44xtDIj5xyJEasF5bcxPZNlie+saiqDIUhr6oeKcP
         hILg==
X-Gm-Message-State: APjAAAUF4OBZJpXibhX28pqJRgeiYAXbndNBY7oReEV75VnMJ2XpppAl
        eHexSvdwxB+lXNLmPlyeSjRiRA==
X-Google-Smtp-Source: APXvYqxw0t+rzh4R6jr62qgnAl4Yazwdm74Ad1r1jDH5XgMpgtQcrIBWRfKbL7ZOcKF1ZbrySW4wjA==
X-Received: by 2002:a62:1611:: with SMTP id 17mr3863307pfw.139.1552579130312;
        Thu, 14 Mar 2019 08:58:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s4sm22148658pfe.16.2019.03.14.08.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 08:58:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com> <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Message-ID: <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 14 Mar 2019 08:58:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-03-14 04:25:16)
> On Fri, 1 Mar 2019 at 03:02, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Why can't we use the debugfs_create_u32 function? It would make things
> > clearer if there was either a debugfs_create_le32() function or if the
> > socinfo structure stored in smem was unmarshalled from little endian
> > to the cpu native endian format during probe time and then all the rest
> > of the code can treat it as a native endian u32 values.
>=20
> Thanks for the review. I've worked on the next version with all the
> changes you suggested in the patchset but I'm kind of not sure
> what would be the best solution in this case.

Alright, thanks.

>=20
> I'm bit skeptical about introducing debugfs_create_le32 as we don't
> really have any endian specific functions in the debugfs core at the
> moment. And if I do that, should I also introduce debugfs_create_be32
> [and to an extent debugfs_create_le{16,64}]? More importantly, would
> it be useful to introduce them in core?

I suppose it's ambiguous if the endianness should be swapped to be CPU
native, or if it should just export them as little endian or big endian
to userspace. I wouldn't introduce any APIs that aren't used, because
it's just dead code. If the code is documented clearly and indicates
what it does then it should be fine. This patch has pretty much already
written the code, so it's just a matter of moving it into debugfs core
now and getting gregkh to approve.

>=20
> In the case of converting it to cpu native during probe, I'll need to
> declare an extra struct with u32 being the parsed version for it to be
> correct. Wouldn't it add extra overhead?

Yes it would be some small extra overhead that could be allocated on the
kernel's heap. What's the maximum size? A hundred bytes or so?

I don't see much of a problem with this approach. It simplifies the
patch series because nothing new is introduced in debugfs core and the
endian conversion is done once in one place instead of being scattered
throughout the code. Sounds like a good improvement to me.

