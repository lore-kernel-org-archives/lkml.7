Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B4421880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oedfKylP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfFMR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:28:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34104 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfFMR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:28:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so23501359qtu.1;
        Thu, 13 Jun 2019 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=pWffWnnz+ElhG5m21Q51hYVp+tij/VSIEpeJT0zysCo=;
        b=oedfKylP7XiL91oxgUEhfNz3Oaa6XwtxNRkYrb0ywhdVbK4s9LxWo5pLBQhnXqxVZO
         mQmpKjRfP0sZ5gjNnC12F6dtaDg5slkw/5ciFU3u4mtMsLQzsH7NMW2N7UmdHFaASSM0
         cGaq1uX0ej4sv3xkM96UfT/TXHrL46MQn3De1qrKpbYbxzrWCub6xik5bNveeDUfXWF/
         AvzBwr/tpr0s6ndXcAyU3KDLNISllkEOBGNnx9slxbBQaY+8nEIKOUt4hnI/kf8vQ4E7
         j2P546W3vp9q1ksff5L+cAFA+Z+Z/TXjVvIOUKg3YWtBH+X1rtszOlcIOQRefn9D4JK4
         dmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=pWffWnnz+ElhG5m21Q51hYVp+tij/VSIEpeJT0zysCo=;
        b=USvEjfh5qkt7p6fCDUVo66/vnkiIaMlQky1LeGlEsmDA1u3AK2PJCCQizYzqc49yUV
         s2V9javFkbY3wsg/fE/QWUG4kgSa56vjmSrcE1tiVrPFiNS5W8ksJFoFuxXHZTrw1sgm
         GjRIqs2mRt1bvc5NdgqxHwHJpSQ0pR2UPdbIr9kgeDzioV79RX7YIaCSGxCJS1r6OQiv
         RivaQPt1Nwn2OZ7vT8D1mrE4rTaLMljCLpElZn4xnY1MIJUCVeIQPzaGhxG8Qw73d2s4
         Q4q0n9yUZ7HihJMVMk6phnv7ZejMP0oc5eKrGIc4n9tjsv70XDDR+rFb+sYS+Y4Xb7hn
         gGHA==
X-Gm-Message-State: APjAAAXwQXVaUVRE8bzmzaRvuB3UBvTeK4l+5QimzV3roi2nED2ampOb
        GT0RgypP/TVOSHBQ76cGKvCPrCJ00v0=
X-Google-Smtp-Source: APXvYqwKFxHoQKwE6Ki+8lrALnBTAGhN8kPBYMCaULDNfD3O3utvkzhcOIHcXWul9rQWJKSU31pIcw==
X-Received: by 2002:a0c:b0e4:: with SMTP id p33mr4659392qvc.208.1560446899040;
        Thu, 13 Jun 2019 10:28:19 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id s134sm109461qke.51.2019.06.13.10.28.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 10:28:18 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:28:17 -0400
Message-ID: <20190613132817.GB22277@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        andrew@lunn.ch
Subject: Re: [PATCH net-next 0/4] net: dsa: use switchdev attr and obj
 handlers
In-Reply-To: <20190611214747.22285-1-vivien.didelot@gmail.com>
References: <20190611214747.22285-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, 11 Jun 2019 17:47:43 -0400, Vivien Didelot <vivien.didelot@gmail.com> wrote:
> This series reduces boilerplate in the handling of switchdev attribute and
> object operations by using the switchdev_handle_* helpers, which check the
> targeted devices and recurse into their lower devices.
> 
> This also brings back the ability to inspect operations targeting the bridge
> device itself (where .orig_dev is the bridge device and .dev is the slave),
> even though that is of no use yet and skipped by this series.
> 
> Vivien Didelot (4):
>   net: dsa: do not check orig_dev in vlan del
>   net: dsa: make cpu_dp non const
>   net: dsa: make dsa_slave_dev_check use const
>   net: dsa: use switchdev handle helpers
> 
>  include/net/dsa.h |  2 +-
>  net/dsa/port.c    |  9 ------
>  net/dsa/slave.c   | 81 ++++++++++++++++++++---------------------------
>  3 files changed, 36 insertions(+), 56 deletions(-)

Please do not merge. The orig_dev != dev test in patch 4 is not correct,
because it skips the programming of the HOST_MDB object. I'll respin in a few.


Thanks,
Vivien
