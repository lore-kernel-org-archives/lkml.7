Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45DC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="slRoN7tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfLMFb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:31:28 -0500
Received: from m228-5.mailgun.net ([159.135.228.5]:34370 "EHLO
        m228-5.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbfLMFb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:31:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576215086; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YrvqTP9z2N2j9Eee0g2uwcZZNKGFYVYmedHWIpnWR2A=;
 b=slRoN7tQ4GZ5Z+vji1lSY6X8vY0kigKtKJkDbtRxxFlFp1j7X9NFnceZ0rpXKMaiXQ0k8MHp
 3MY7Pqf3nZi6HV8KNEEMNREzeXtRxdiU9mXOTTKGjZoaSKBl/MkXysg+vNLxmu4Zz1Q2ubDK
 A8IFVse4rHFHhhN5YeZIopN2HVg=
X-Mailgun-Sending-Ip: 159.135.228.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df3222c.7fd25d5ad3e8-smtp-out-n01;
 Fri, 13 Dec 2019 05:31:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8198C447A2; Fri, 13 Dec 2019 05:31:24 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1B48C433CB;
        Fri, 13 Dec 2019 05:31:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Dec 2019 11:01:23 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        psodagud@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        tsoni@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Richter <rrichter@marvell.com>,
        Andy Gross <agross@kernel.org>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
In-Reply-To: <5df16ebe.1c69fb81.6481f.a011@mx.google.com>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a6311-e815485c-4b77-4342-a3de-203673941602-000000@us-west-2.amazonses.com>
 <CAE=gft5JvCegmrjkKuxYr9dgASPFCkgy97O1XGRyKDF6xT=BMA@mail.gmail.com>
 <5df16ebe.1c69fb81.6481f.a011@mx.google.com>
Message-ID: <624229b9b2d5bf4b5eccf7778b420e2d@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 04:03, Stephen Boyd wrote:
> Quoting Evan Green (2019-12-11 11:32:37)
>> Hi Sai,
>> 
>> On Thu, Dec 5, 2019 at 1:53 AM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>> > diff --git a/drivers/edac/qcom_kryo_edac.c b/drivers/edac/qcom_kryo_edac.c
>> > new file mode 100644
>> > index 000000000000..05b60ad3cb0e
>> > --- /dev/null
>> > +++ b/drivers/edac/qcom_kryo_edac.c
>> > @@ -0,0 +1,679 @@
> [...]
>> > +static const struct error_record serror_record[] = {
>> > +       { 0x1,  "Errors due to fault injection"         },
>> > +       { 0x2,  "ECC error from internal data buffer"   },
>> > +       { 0x6,  "ECC error on cache data RAM"           },
>> > +       { 0x7,  "ECC error on cache tag or dirty RAM"   },
>> > +       { 0x8,  "Parity error on TLB data RAM"          },
>> > +       { 0x9,  "Parity error on TLB tag RAM"           },
>> > +       { 0x12, "Error response for a cache copyback"   },
>> > +       { 0x15, "Deferred error not supported"          },
>> > +};
>> > +
>> > +static const struct error_type err_type[] = {
>> > +       { edac_device_handle_ce, "Kryo L1 Corrected Error"      },
>> > +       { edac_device_handle_ue, "Kryo L1 Uncorrected Error"    },
>> > +       { edac_device_handle_ue, "Kryo L1 Deferred Error"       },
>> > +       { edac_device_handle_ce, "Kryo L2 Corrected Error"      },
>> > +       { edac_device_handle_ue, "Kryo L2 Uncorrected Error"    },
>> > +       { edac_device_handle_ue, "Kryo L2 Deferred Error"       },
>> > +       { edac_device_handle_ce, "L3 Corrected Error"           },
>> > +       { edac_device_handle_ue, "L3 Uncorrected Error"         },
>> > +       { edac_device_handle_ue, "L3 Deferred Error"            },
>> > +};
>> 
>> A comment is warranted to indicate that err_type is indexed by the
>> enum, as this would be easy to mess up in later changes.
> 
> Instead of a comment please use array indexing.
> 
> 	[KRYO_L1_CE] = { edac_device_handle_ce, "Kryo L1..." },
> 	...

Will do this in the next spin.

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
