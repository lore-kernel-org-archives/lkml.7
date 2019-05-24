Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAA3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B092075E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umKy+t+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbfEXNT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:19:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47009 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:19:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so7443999qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XdN+SJO4nNfooj9kJ5ndy5j9Cl/+8FH0MeIweuOGzA=;
        b=umKy+t+dNFNuRN3//yw8fJR6BmKynML3xuh30YRuWun2gOZ+W2hNgIWycKEjShbKbd
         +FaBLWWcJmgMHcMDZbJpme0B+zf+ew2DoIP3CGphOfrE7Uuv9JuH+Azx0JvVqPoUY69M
         8HdcUI0H3BJrfLosqseHHAHfiHj4KGX/ihlnRjVwBaCFLFsBmnSouSuJszVLhKJrYcwx
         8tQyWrNqwS2t+IfxysJ8FFxfS+5AG4ufj3xnhx+Gy9VtowqTETLuytKmYD3+BKSs5gml
         DcHLVCrIjW6guYl6IsMmAwxSbCC6nvhrn/xRdCsvVhDlb5k3q26iQg7IVg4+fGtcbDKS
         r1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XdN+SJO4nNfooj9kJ5ndy5j9Cl/+8FH0MeIweuOGzA=;
        b=cU23KoQ7t5S5u5mN/+X7GPqT4gZ9Ta9iH6vvExapZwtsX3OeLwPuMdlWy31DX1ncer
         QQC7gNUgM03hukaeI3hE7rezsbnuCSRDHraq5SZMCH7OuYgOX9FweHJpFdzmy5ToLzKy
         XoTH1Cheo/7vrxfo0IqQwE8Rsw6U9yx9XbQlJC2eRYKQO+quc1R0C+BOUE7WwM5L3Psm
         lBIadMT8ewZGCE2r5Dwo8aNP1kiPQ2AOJU96dKh/ZaVsqzvpYA4HTwM8KflxeZhudRVX
         azxwB+YDFOzrxabuU9G/5NjrGrxuJXG7Nw6NZ+ESy0io5Ua7wuONQrHOZRS1us42RF/L
         BsnQ==
X-Gm-Message-State: APjAAAXWoA92h0CxnAvubUNhe0D2qlMVOmD0eZUhOtKZleMYq5G2R20q
        uDisdLQC0/KRTCMykggnl3anG2DuERDBdSWxAExmzg==
X-Google-Smtp-Source: APXvYqx9KM7Yc5ojQbqNvCzGfvIIOam7qCdkDSAjgKM3Z0ld27IhHfeKfkMag3SA4N0Hdi+ZJCJ+jc69aHauc+MA8mw=
X-Received: by 2002:a0c:8b54:: with SMTP id d20mr28830004qvc.1.1558703996214;
 Fri, 24 May 2019 06:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <20190523143227.GC31751@leoy-ThinkPad-X240s> <23a50436-4bcf-3439-c189-093e1a58438d@arm.com>
In-Reply-To: <23a50436-4bcf-3439-c189-093e1a58438d@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 24 May 2019 14:19:43 +0100
Message-ID: <CAJ9a7Vjh_RDgp6nKrgrmuKcAhs77iU_oKTuBhSBdkUUwiwZbSg@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki, Leo

On Thu, 23 May 2019 at 16:32, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Leo,
>
> On 23/05/2019 15:32, Leo Yan wrote:
> > Hi Suzuki,
> >
> > On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:
> >
> > [...]
> >
> >> Changes since v2:
> >>   - Drop the patches exposing device links via sysfs, to be posted as separate
> >>     series.
> >
> > Thanks for sharing the git tree linkage in another email.  Just want
> > to confirm, since patch set v3 you have dropped the patch "coresight:
> > Expose device connections via sysfs" [1], will you send out this patch
> > after ACPI binding support patches has been merged?
>
> We are awaiting Mike's comment on the approach, as his CTI support also
> needs something similar.
>

I fully agree that there is requirement to expose device connections
as Suzuki's patches provided. As commented in the original patch, it
removes the need for users to have knowledge of hardware specifics or
access to device tree source.

For the trace datapath a simple link is sufficient to express this
information. The nature of the data and connection is known - it is
the trace data running from source to sink. The linked components are
guaranteed to be registered coresight devices

However, the requirement for the CTI is different.

CTI is not limited to connecting to other coresight devices. Any
device can be wired into a CTI trigger signal. These devices may or
may not have drivers  / entries in the device tree.
For each connection a client needs to know the signals connected to
the cti, the signal directions, the signal prupose if possible, and
the device connected.
For this reason we dynamically fill out a connections infomation
sub-dir in sysfs containing _name, _trigin_sig, _trigout_sig,
_trigin_type, _trigout_type - described in the patch [1].

This information is sufficient and necessary to enable a user to
program a CTI in most cases.

As an example look at the Juno dtsi in [2].
CTI 0 is connected to ETR, ETF, STM and TPIU - all coresight devices.
CTI 1 is connected to REF_CLK, system profiler and watchdog - no
coresight devices at all.
CTI 2 is connected to ETF, and two ELA devices - so 1 coresight device
and 2 not coresight devices.

So my view is that for the case where CTI is connected to another
CoreSight device the sysfs link could be used in addition to the
information described above.

Regards.

Mike

[1] https://lists.linaro.org/pipermail/coresight/2019-May/002587.html
[2] https://lists.linaro.org/pipermail/coresight/2019-May/002589.html

> >
> > When you send out the new patch for exposing device connection, please
> > loop me so that I can base on it for perf testing related works.
>
> Sure, will do. As such, the perf testing should not be affected by that
> series. It is just a helper to demonstrate the connections. But yes, it
> will definitely help you to choose an ETF for a cluster, if you had multiple
> ETFs on the system. Otherwise, you should be OK.
>
> Please be aware that the power management support is missing on ACPI platform.
> So you must make sure, by other means, that the debug domain is powered up.
>
>
> Cheers
> Suzuki
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
