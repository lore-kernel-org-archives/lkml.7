Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D4C2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnt8fWuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfC2U3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:29:45 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42036 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfC2U3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:29:45 -0400
Received: by mail-lj1-f182.google.com with SMTP id v22so3088847lje.9;
        Fri, 29 Mar 2019 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzkZkrb10rJl1on/WCEES/BRYAEi/aY2ZNRHHwlByHk=;
        b=Dnt8fWuNqegYca7InB6h6WmQWI7Ri+Q9EZI7nCAYpSePFY20slSBIFVDMX5glqeT1g
         YCubaZ/Geg4sDRKVGKXJwMmeVbQz2Rd2eWmuIkIrvtdNt/ZaIkm2vIlfWTdrBGjmkFBr
         9M/Ze4wXXWPpvWLEuu7uVSApdo1LjSKtBfn1Fb7tDvtqRH4NcctRvUdbIc+fQduBl/V7
         s1K8IQPgq26SJXXmPbnoacHum+x1UXaRKMoULSZfE+TqOFmSQoIDGY51+CUoEESxLTXF
         XATq66lZGdyWMc19cNpAdSIn6WjXsV4twneQoJzc4NS9MKqpk5LXOAw3tXPmyvcIUYRX
         TKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzkZkrb10rJl1on/WCEES/BRYAEi/aY2ZNRHHwlByHk=;
        b=KmSCTX/z5EOsb1O2hnuzWrcVAHH4UiMcn4wAR+0PLW+3SYjvyCDIdWYeqbTvJijHsM
         H5P/etYpBo6uZu58oyYuPQ2FhTcLPpigA2nquouyIdxolA90UgPBXDAEl1s3sBzXEydA
         yY6j9bA2ppg6H+rppJbuU7o1azo3Y0cdjaCcfVb0kicUjQPdPuTgPK/oNnkdkC9nRFP3
         uXPKTCpcKTuvkYhar40+PNJUGnih6u1IKUbPu3fUB4JDLQyxfdtWgTwqkn8tPM6rA1Yw
         ns3aMfOJBW2wKqJbEpcKHO3lAqPECSmHTvVXKGCnMMUXTPuIa2biJNAjLq/KpU9V6Kim
         K8vA==
X-Gm-Message-State: APjAAAWvLYKal8GXrdB5h/4lou0K0/7aEEv2Uy7pmc2b3JnKN8HHpbVH
        AcyENVRU3sbKiSV1WRQELOM=
X-Google-Smtp-Source: APXvYqyuGH6xABgM6tl7IdhDTlankBwSK0wEBbkJWlsxccjJ/UVTyxa4oN5buZ04JfVqucTeySGdIw==
X-Received: by 2002:a2e:4209:: with SMTP id p9mr20934461lja.175.1553891383056;
        Fri, 29 Mar 2019 13:29:43 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id l16sm542645ljb.24.2019.03.29.13.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:29:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 0/2] media: ov6650: Add V4L2 asynchronous subdevice support
Date:   Fri, 29 Mar 2019 21:29:01 +0100
Message-Id: <20190329202903.5622-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190325003501.14687-1-jmkrzyszt@gmail.com>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Janusz Krzysztofik (2):
      media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
      media: ov6650: Register with asynchronous subdevice framework

 ov6650.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

Changelog:
v1->v2:
- labels should be outside conditionals - thanks Sakari
- rebased on my former fix so it applied cleanly

