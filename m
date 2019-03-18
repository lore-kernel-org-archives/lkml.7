Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F16C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825CF213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sRlEqDEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCRUOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:14:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45945 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCRUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:14:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so15583308otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCaVs6o3RVpxDMzAy4B4Wg4rQyGWz3EtKJvXXlUnELM=;
        b=sRlEqDEnddOSXulQi2zIzuiXXowkkmjCs73LvIheiz7tLe5bOygwhS1y8OwRWLWn/3
         aV9MD6h/MI5dElzC5AVyhEyPmOLIPkrxF2jIoJwJBzxhGGiBh1WcTSCh0VLnSyplRDJU
         vXxhbOIov6z9SsJOnJBF1o7J2XaoUV+t8XoisNOOmHfwCa0ildR3AOzdbNRYgqX3lI00
         AEUxQrMy5X11Ag0akcYsWSmpkQ/d5bnCzxsQpZ2W+KhMLCM8E9vlrXnzKclOwENHUrVC
         Ecn5kbajwGuK7H1b8SUkfQGvz90roEUUI/LndVzcPS1jaUgAPRq4P6gqYKHgHMonroKs
         Zkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCaVs6o3RVpxDMzAy4B4Wg4rQyGWz3EtKJvXXlUnELM=;
        b=F8W9XZ5td/vaDCJBaTBbisEOyqLOyFu83htl7joXOQAuHF/6snT6NB8q7fzIxfJul7
         I2eoQm3LSFULQCK5amMk04AlcbVKx450FO+mfnlO5+u+Pcm3KaP8gWUlqk8E5W2z6i3E
         t9ARkzwRasd0bL2Yd668lB4CWwHm1XZXwko+KcUgDmujOYt1qj50kyUEMjeu3NUJCVhB
         CiJL4O9UZYhD81+jDxluPEgwKpjlX86NsxfuF6s0pDxKqoDpiyNY0bHM3NH5Jar4fTSx
         eVa+SkzNk7K6ARaT06rn0Qj/mmVcDczDqtRM8Chk7kQi+0g7jq6VgAN6qBcXPSmHI7CK
         UNpg==
X-Gm-Message-State: APjAAAUlI+mzNqaWbea+SJctaPEdrjhquFO0X05rlBoc25zkHMvK8mDV
        QoJyskgZwwEvBc768XfUdAo1r9yjZjQth4hxo5/vcZi0
X-Google-Smtp-Source: APXvYqxwLPzvdW6+al7blZTxDDmQzklARpXfix4SUwy6Ucxd/tq4ChtYDInpoe+XNcj0qOBXbYEzLvsFW4l6L8QgdUQ=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr11332286otk.86.1552940040997;
 Mon, 18 Mar 2019 13:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-10-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-10-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:13:50 +0100
Message-ID: <CAFBinCBWSoPoJ6F1fWdzE9Ogr+udamPYCYb=JUhuUb1hXf_yOA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] arm64: dts: meson-g12a-sei510: Enable USB
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:07 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the USB2 and USB3 Host ports on the SEI520 Set-Top-Box.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
