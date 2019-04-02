Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49448C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C52075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fwtcZix7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfDBFWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:22:14 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42894 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfDBFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:22:13 -0400
Received: by mail-yw1-f68.google.com with SMTP id e76so4143292ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 22:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOGIs9WNerTGX7LDKLjBk1DE37QWrZaAIzrr8nImeqI=;
        b=fwtcZix7hnHZLir+w1X9DesyTlez9ZBELiZ7FdJipU28UqjyyjsVd5E7Hfp23XoZ66
         Hh7zAQB69HkB8SfIcNeCLm+EIQ1dDVkjmXw0e3OsL9Pgtb4oanh31jNR4LPVkNwVpkCv
         pX6vRVnN+/XvVjLRXAzf+4D0pRA+UAEKHAy0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOGIs9WNerTGX7LDKLjBk1DE37QWrZaAIzrr8nImeqI=;
        b=eGNoHpyXtZJtE1ieP7+pNLWUu67ydwUXTRrcjr0NwTBzO/f0NU+prD+hAqeNzOs2MN
         CWRSehcrsWYOpIcqHq/m6sfhnOWicsaSdZiqcWqVrpe1QtzSCNwfMrviBTwD0jeHRxyM
         Wt4xu3+08gEPYzSZyL4yYdG2OO4/vV/wbmpL9WuAvfPqBOjUH8THAYhIQhSsN9qDxppq
         0rRHG+AjV6SESq2dsOG7GY9QR6rHxaoodQ/riNmJFEuJBTWivpHoA3Mes3Dr2NhJcXcV
         eg7vLJTauzq32D+TqKi8z45WchVfPoIYinqg+QSMDsKcEnqLqSNHKxPnLV+cinfz+Fb8
         lz8A==
X-Gm-Message-State: APjAAAU12utO59VL6Aa8GHggWbMAsxwIRo4UV7OTJYXMO1dH5pJA1FRc
        zvb18h17b2CZ0hCjwFp9YAOiLWtE/7u0tKvCv8hroA==
X-Google-Smtp-Source: APXvYqyLPwuHtbgmNczJoUnjhJnwnlm7UeOpLsczZDxr5rc4NMJuVF/25XQzgEEKC335r5jRQo1ASYYQM3He8nb6E8k=
X-Received: by 2002:a81:1e51:: with SMTP id e78mr57867540ywe.302.1554182533047;
 Mon, 01 Apr 2019 22:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190402050756.20507-1-jmaxwell37@gmail.com>
In-Reply-To: <20190402050756.20507-1-jmaxwell37@gmail.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 1 Apr 2019 22:22:01 -0700
Message-ID: <CACKFLi=kJ3FLuXFchVQ2mf0K09E7y5iVJNBTPsFZiv3Zaafitw@mail.gmail.com>
Subject: Re: [net-next] tg3: allow ethtool -p to work for NICs in down state
To:     Jon Maxwell <jmaxwell37@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        "michael.chan@broadcom.com" <mchan@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, jmaxwell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:09 PM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>
> Make tg3 behave like other drivers and let "ethtool -p" identify the
> NIC even when it's in the DOWN state. Before this patch it would get an
> error as follows if the NIC was down:
>
> # ip link set down dev em4
> # ethtool -p em4
> Cannot identify NIC: Resource temporarily unavailable
>
> With this patch ethtool identify works regardless of whether the NIC is up
> or down as it does for other drivers.
>
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>

We used to power down the chip in tg3_close() and that's why we cannot
do ethtool -p after close.  We don't do that any more so this is fine.
Thanks.
