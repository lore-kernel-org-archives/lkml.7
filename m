Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABCD2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EIdFRpQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJGTxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:53:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38524 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:53:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id e11so12084262otl.5;
        Mon, 07 Oct 2019 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll5VS0x0qwRlI1DbZskmr3yCSs+Go2cpezmUSbolVCc=;
        b=EIdFRpQSncyAOHMQgWjBLVBy/iiy0eu9JqVJmgwbS9HWCpD8moz+FXya2Kep61U9dD
         pN4F3pzyHiW6X5ryOoyXBfRCz/t81hRCVnJmrPkU4l1LIB7c3ro71oijT+YdhSFXvs6d
         U9Yqu9oru/fZJxQnGsox54xhPr5a/7K1cDhONCh4L7tZU33gm0SNAzX8PGJzoV/bCImV
         WwBhP3zYBGhTcCFxmLaGeYRGT3jkcY1aHwoGQ14FAfV5o9pYU45vkxRglc+mmtNgE1Om
         2ATfFleQzeKvwJvNA6F+oNy/JaGmAEDcEEQ6iv11qNJrLMr8+/u6CLLrzBV5mFcOgOo2
         d2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll5VS0x0qwRlI1DbZskmr3yCSs+Go2cpezmUSbolVCc=;
        b=UWTv7AuDIonQXGGShFK75FWLEjiHGBGkpYyyMmk/G8PrPQPrqKRsyvuFV8YY669HCU
         TyDYo2wrbqUx7eKZ4Ybgx3Uz0S/0HBDQT0hfVwo25k3aQEhmKFqQGfd7x+Zn2TsRTVIn
         g+wBVzuGCjRztzplOGvWd8ip4ogBjjV+ap/CoPr3h3nkj+i1z+cD8U6YaHjbWe0C6Rb8
         Eqe+t6BdM2Lh9bXmwEp2dSBQpPjpp3DnsB+70FrPh5VzjUf3ENAoCL7BULGY7W4VE5mO
         Zrw1gvuDwTLujhDy4ceZWkYWmbVycU/3fgsLRk41/MXrJnfazvIBelBOfK3rp26W+Yab
         NABg==
X-Gm-Message-State: APjAAAVpxy/XBDc0/oVAPeCgCiTViVNypty6gNmCA1Q6at84dd9BWB9e
        jS6y3JJUzbCVP43hb5/0v0i8O41NfvYxTZtj9ps=
X-Google-Smtp-Source: APXvYqzyRnHOL8L1RxGOfmZmnY9K3vPLs6gBLlrxBWtK7FN2LBPCNtg9PPlD8sq6YTxvIDS/btXULsIxjZpHL6DvzK0=
X-Received: by 2002:a9d:69d7:: with SMTP id v23mr14303688oto.96.1570478011317;
 Mon, 07 Oct 2019 12:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
 <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com> <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com> <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com> <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
 <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com> <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
 <20191003141955.zi5wqjqf4wa7lhv7@pengutronix.de>
In-Reply-To: <20191003141955.zi5wqjqf4wa7lhv7@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 7 Oct 2019 21:53:20 +0200
Message-ID: <CAFBinCAEzBk7tT5M-F3H4kLnKURRkK2oSSAmKkrjAn7_wdAROA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Philipp Zabel <pza@pengutronix.de>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, Oct 3, 2019 at 4:19 PM Philipp Zabel <pza@pengutronix.de> wrote:
[...]
> > because the register layout was greatly simplified for the newer SoCs
> > (for which there is reset-intel) compared to the older ones
> > (reset-lantiq).
> > Dilip's suggestion (in my own words) is that you take his new
> > reset-intel driver, then we will work on porting reset-lantiq over to
> > that so in the end we can drop the reset-lantiq driver.
>
> Just to be sure, you are suggesting to add support for the current
> lantiq,reset binding to the reset-intel driver at a later point? I
> see no reason not to do that, but I'm also not quite sure what the
> benefit will be over just keeping reset-lantiq as is?
according to Chuan and Dilip the current reset-lantiq implementation
is wrong [0].
my understanding is that the Lantiq and Intel LGM reset controllers
are identical except:
- the Lantiq variant uses a weird register layout (reset and status
registers not at consecutive offsets)
- the bits of the reset and status registers sometimes don't match on
the Lantiq variant
- the Intel variant has a dedicated registers area for the reset
controller registers, while the Lantiq variant mixes them with various
other functionality (for example: USB2 PHYs)

> > This approach means more work for me (as I am probably the one who
> > then has to do the work to port reset-lantiq over to reset-intel).
>
> More work than what alternative?
compared to "fixing" the existing reset-lantiq driver (reset callback)
and then (instead of adding a new driver) integrating Intel LGM
support into reset-lantiq

> > I'm happy to do that work if you think that it's worth following this
> > approach.  So I want your opinion on this before I spend any effort on
> > porting reset-lantiq over to reset-intel.
>
> Reset drivers are typically so simple, I'm not quite sure whether it is
> worth to integrate multiple drivers if it complicates matters too much.
> In this case though I expect it would just be adding support for a
> custom .of_xlate and lantiq specific register property parsing?
yes, that's how I understand the Lantiq and Intel reset controllers:
- reset/status/assert/deassert callbacks would be shared across all variants
- register parsing and of_xlate are SoC specific


Martin


[0] https://www.spinics.net/lists/devicetree/msg305951.html
