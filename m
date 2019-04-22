Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C67EC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otc2/zJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDVC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:57:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43233 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfDVC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:57:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so5113307plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGJoT5iB3bTc4LGaAwtIuRxmdPfiW9i6PCIuaqVn52U=;
        b=otc2/zJtPE0IMHOpA6/YsVhEgmLq1Lk+8YDlDwTaIx6wvy/pma9tCX6qYfBUJnvhFO
         QsRZ180OuByZxxtUFm5P0tZxuxrF/bl6aqkOTI4sjXB7fHcnu4Fk2id53oYfi0JH2J6P
         s0F1L4upKQmZ1gK7I0VqViPXpdDjVTpaNUPmK3LziFLjIkZ8jVhf/tcVND8DBTKgNoam
         E5RQ+Gwc+41/dqnCcJhsek8ctu0TAtp8b+kyvVaWwx2Q0ipgkevadNdLTexHB9w5XyHT
         Vg2OZ/MJ9uR2ZYd2FU7swkmMJ4G92yB1897g+c1H+AryRDEpx5oc9+W0fhXCSKobUa/l
         CrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGJoT5iB3bTc4LGaAwtIuRxmdPfiW9i6PCIuaqVn52U=;
        b=QT64BmwEu/3SNeQOxVVMtLvRQ1TihJ6cM4lEpS0Q6eR+7gm4Lg16PfNy7hr2RQS3EH
         LeUAt4w5zoMQHwdi2b70VpTDxLnktmDLMj8lO+Q0yMNX8t31YWFmmBaA9xUgaS56hW0Y
         eUKirBwHZ8SnEcW+o0lTYKFThkyczwj7JZOKHVPagLq26GjJr08MOj9fbgHSsZI/33Bj
         aE7rZxBNGq/AKkDHCne7JqH4jlk0b/GqV0TjoAHFes44uL73qc+Bb5egktwbOSGp4G9q
         Yf+6/IS3zNbd2zkOWhOV4CQsXnTaUyi6bW7cLN23/D3J/wUDFBH6rLXykZmihcs5vO3J
         PiTg==
X-Gm-Message-State: APjAAAXnQmr/lk1sOMjh5fK5NT3hJP+7WxIqyqzhlDp8OnJVTJzsmU6c
        NGi1ckEFlnkz1QuW8m3gv0E=
X-Google-Smtp-Source: APXvYqxy4ekFS/1HN5LPbs7i85iomf4KFHFlaxlE4v9IhjO13xxemVUJeOREIBDYANBXhvq/LkikrA==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9mr17760317plg.239.1555901844050;
        Sun, 21 Apr 2019 19:57:24 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id f2sm17202364pgc.30.2019.04.21.19.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 19:57:23 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:57:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190422025715.GB9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> When we want to support more sample rate, for example 12kHz/24kHz
> we need update the process_option table, if we want to support more
> sample rate next time, the table need to be updated again. which
> is not flexible.
> 
> We got a function fsl_asrc_sel_proc to replace the table, which can
> give the pre-processing and post-processing options according to
> the sample rate.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

A couple of more small comments.

And please add this when you resend:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin

Since we have a ratio validation somewhere else, it's okay to
drop this line -- it may confuse people since the function no
longer checks these unsupported cases.

> +static int fsl_asrc_sel_proc(int inrate, int outrate,

I think "void" type should be just fine as we made sure there
is no unsupported cases running in this function.
