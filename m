Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B23C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE503204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCDXb7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:31:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44929 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:31:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so5808380otj.11;
        Mon, 04 Mar 2019 15:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+c3uJmrhVEjaVapM7vNizW7J+PWDa1subOrbmknF5+E=;
        b=g/AhOcuz2OcPgwWryQhb0zer7fkwrHGDNlGNHGEf0Klztx49vLseoeKL0DzcGL9NMr
         Ex1DJogVSa3VqQllrxQPl+07oojwWbr6YlAIZjqEnmn8jx5e3nOzUuFPCbfj3qlLWsrn
         hxx029RCx6uo9/sI77pdqZ3CWM/fDJFGyPYUYQ2ZUTeZ3M5K0+T0fkX6ixRxwIuAdwKH
         3zfcD2RhteWnHPLvSyP3PEtV+M1fGkM1xykcD576cMq21InRK0wifvF+xLnAixb7RaeV
         J8FES8ZjfsbRPB41GPHbnCrdFnfZnEbGAHiMiaKMdU4iq+JCp0bZQJLXb1rB7WbDsOCN
         jWkw==
X-Gm-Message-State: APjAAAULXAjkc1Tt3Uwk5sBIEfSzw0L0Pfb7Et9YSTpoQrfSr3YZtLM6
        sWVMd+hp0Rh/x1c48hMfQPAYU1BN56Y=
X-Google-Smtp-Source: APXvYqyek19PF9qwEICD8J3iCctXBw0/aLJwfuAos5fx1zqeHqKkVXgztMAg9x5ogdF12y2eYsu7xw==
X-Received: by 2002:a9d:7b49:: with SMTP id f9mr13814355oto.211.1551742317972;
        Mon, 04 Mar 2019 15:31:57 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id d67sm3239733oig.36.2019.03.04.15.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 15:31:56 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id c18so5793167otl.13;
        Mon, 04 Mar 2019 15:31:56 -0800 (PST)
X-Received: by 2002:a9d:6255:: with SMTP id i21mr14048069otk.158.1551742315884;
 Mon, 04 Mar 2019 15:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com> <b2cb92de-ef4a-d628-0dd3-76d8d1b953d0@linux.alibaba.com>
 <CADRPPNSjf4P14bwUMsa10XzBUVLszx4iMsL6gk-XQ0x3vTFr+g@mail.gmail.com>
 <e342a3fa-20f6-46cd-4240-8403fa1aa736@linux.alibaba.com> <AM6PR04MB586370DDB6E73A43673339568F710@AM6PR04MB5863.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB586370DDB6E73A43673339568F710@AM6PR04MB5863.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 4 Mar 2019 17:31:44 -0600
X-Gmail-Original-Message-ID: <CADRPPNTxDDquY=OT4MV6cQ8OHhAdbazMjngDhtRBCE9_UESg_w@mail.gmail.com>
Message-ID: <CADRPPNTxDDquY=OT4MV6cQ8OHhAdbazMjngDhtRBCE9_UESg_w@mail.gmail.com>
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Coly Li <colyli@suse.de>, Federico Vaga <federico.vaga@vaga.pv.it>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "harryxiyou@gmail.com" <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@zh-kernel.org" <linux-kernel@zh-kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 1:22 PM Leo Li <leoyang.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alex Shi <alex.shi@linux.alibaba.com>
> > Sent: Monday, March 4, 2019 1:58 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Coly Li <colyli@suse.de>; Federico Vaga <federico.vaga@vaga.pv.it>;
> > Fengguang Wu <fengguang.wu@intel.com>; Li Zefan
> > <lizefan@huawei.com>; Shawn Guo <shawn.guo@linaro.org>;
> > corbet@lwn.net; harryxiyou@gmail.com; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-kernel@zh-kernel.org
> > Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
> >
> > Hi Leo.
> >
> > Do you know others' email address except yourself. I guess leoyang.li is same
> > one as mailto:leo@zh-kernel.org, is this right? :)
>
> Hi Alex,
>
> I will try to get the new email addresses for others too.   Yes.  But probably I will use a private email for this instead of the company email.

Here are the updated email address for me and others.

TripleX Chung <xxx.phy@gmail.com>
Li Yang <pku.leo@gmail.com>
Zhang Wei <wezhang@outlook.com>

Since you have created the patch to update my email address to my
company email, it is ok to keep that.  Thanks a lot for the effort to
address the issue.

Regards,
Leo

>
> >
> > Thanks
> > Alex
> > On 2019/3/4 2:30 下午, Li Yang wrote:
> >
> >
> > On Mon, Mar 4, 2019 at 12:23 AM Alex Shi
> > <mailto:alex.shi@linux.alibaba.com> wrote:
> > BTW, Corbet,
> >
> > Some of email address are unused and
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fzh-
> > kernel.org&data=02%7C01%7Cleoyang.li%40nxp.com%7C6b64721b126944de
> > 835c08d6a0771379%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63
> > 6872830634024412&sdata=cMnFjRjAzodh5IgFVaZvZpmXNXfHb%2FwWCTxwt
> > t%2FO6e4%3D&reserved=0 web site are unused and on sale. That are:
> >
> > The website has been down for a while and won’t be reopen.  But we can
> > definitely update these email addresses.
> >
> >
>
