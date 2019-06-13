Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146F020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF0VHOhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbfFMPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:50 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39147 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbfFMI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:57:28 -0400
Received: by mail-wm1-f47.google.com with SMTP id z23so9215603wma.4;
        Thu, 13 Jun 2019 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iTc7pkQE7oYIi5Tpm8V4ZpSzYMCgq4jwm9PdqCuT8KQ=;
        b=bF0VHOhiXklHX7toUG8Z6iKgvhfsMkGA7P/ETJzRztQ/j4qWN3iWThkhFG/qeJ0EPI
         oEYadE5A+YmD7M54wbT98jsXnhiyWer7EsFpP2IhyFEz64p97i0QisADuCWABntzcmcB
         tiX5bWPPtxkAqboy5hoNYCQyuo8MYW59KS+ij4As20TJtQoLKXPxGaeG6fwawMG3a0sQ
         7wbkdG70X/OUpSctSZVfWGYA64YquU3pJTw6IYCB9aYWzGl33ug5V9CpHebckq4T7SLV
         erV7TGs6pQl9qb8Hlj44CORUO35HHLbqroxTr0s249qYEruEH96rGmiyYIYOlXnY+KSi
         Zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTc7pkQE7oYIi5Tpm8V4ZpSzYMCgq4jwm9PdqCuT8KQ=;
        b=WDd9hkvHcX89H1Boumx6P2AcY72mC3ne4R4gyBeZIak+/cTy6vyA2AQ9plMoG5dqwW
         Y1jK/dAjclNTmZgoRcgEeiY5RRAJLJvM/bH7YtrepKaGhOD3ZxK6pJBgdYr5Wh6kJiPc
         6xW4N3+kNS1/w7V51nRBzlTU7mjEbh6kqHuLQSZbdr1z5qLpt2x4ceuvYAomQxe4EBGR
         hnbqXJbDF51r5TOHldvX8k8xjNLjz4oojtuLX1rxCKtRu3blqXYY+VRFcIb0g+Hpwn8F
         9SU7R1Y3qWNIac+v8gY2srz40wu+u8qT1b4MCvI44JpRvQ2oXh0GLeJRSXZ+VUj5N82v
         1eqg==
X-Gm-Message-State: APjAAAWFArgJg71qeZXyFy4we6HN7ur4bkaSzUEK1wGkcEaCNFtdZztb
        fessBUFLysCAXtnscIhhom4=
X-Google-Smtp-Source: APXvYqxfKZPFzSQgRbvPc2K4axpRnhCZmruX7sKl8YaXA22qKpUpYCZQPxVeOfMECWNTuV9EPe/+Og==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr2854522wma.114.1560416246274;
        Thu, 13 Jun 2019 01:57:26 -0700 (PDT)
Received: from gmail.com (net-37-119-6-250.cust.vodafonedsl.it. [37.119.6.250])
        by smtp.gmail.com with ESMTPSA id x129sm2689276wmg.44.2019.06.13.01.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:57:25 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:57:25 +0200
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Paolo Pisati <p.pisati@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: msm8996: qcom-qmp: apq8096-db820c fails to boot, reset back to
 fastboot and locks up
Message-ID: <20190613085725.GA11403@harukaze>
References: <20190610134401.GA12964@harukaze>
 <20190611171225.GA21992@centauri.ideon.se>
 <20190612131735.GB11167@centauri>
 <20190612140911.GA16863@harukaze>
 <20190612162048.GA30551@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612162048.GA30551@centauri>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 06:20:48PM +0200, Niklas Cassel wrote:
> 
> Can you still reproduce the reboot?

--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -447,12 +447,12 @@
                        };
 
                        pcie@608000 {
-                               status = "okay";
+                               status = "disabled";
                                perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
                        };
 
                        pcie@610000 {
-                               status = "okay";
+                               status = "disabled";
                                perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
                        };
                };

disabling the two other pci controllers (and leaving your previous patch
applied), made the issue more frequent: i was never able to boot to user space
three times in a row without experiencing a crash, previously it was more
sporadic.

On the other hand, now i can reproduce the issue more easily this way.
-- 
bye,
p.
