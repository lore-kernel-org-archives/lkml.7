Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8D5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B919D25F2E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fortuneproleads-com.20150623.gappssmtp.com header.i=@fortuneproleads-com.20150623.gappssmtp.com header.b="KaTcjzr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfE3SM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:12:56 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36586 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3SMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:12:55 -0400
Received: by mail-pl1-f176.google.com with SMTP id d21so2893354plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fortuneproleads-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FtcZFLtCFY9iWybUxhzgJqd7gGygMM22zI+PAShbE9g=;
        b=KaTcjzr7LpxuGDxbmfugGTdNQUwN/yztLHJ7gPdnb7jd6AwlgmabqHlpGAavt8ESyJ
         wGOuWVxRfJqUFYjwTILiLORhH4qLIAM6F6/4GpsEYi9fiB9FAeJHWtMg8YjlPdzDeUvX
         pbcZkh0OD5B8kpMBhGwkoNPX4eiG2WlIy8JnGF9Udfa0GmB57puczYLBlB9biNoHHzUY
         hLv99/YuuvMF168k9CLT1ZiXcbiHEUvmpLcvASeW6bo4Fcgvt3fDxtKeRBlH/BW2wiOw
         0QeukD0l7WxtS/jM8zMA0WjKx6k7nYprSZvq45wuQZEyxhMAaF8KhUH1hStGyaAX/uWc
         E19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=FtcZFLtCFY9iWybUxhzgJqd7gGygMM22zI+PAShbE9g=;
        b=JtC4uL2XnNBdR5i3A13RrxW0nNb7+yP0MqL7mBa/EKafagiY8SB5XfHKI0SEXKmM86
         RFyr0Eu59N1f05nO7+RpyWwd5uqqdv3CoWg1W2JDprVKlRm8b0SHE24W/Icoih6qKk/1
         YvjWDwrgmPBCR6q80Og1UYYYUWkouA3F1GOSAg8ngseyB4IQDlgZBtMEn9hnourHiejD
         Y2TMv6RUamp7olN1knIGGH1ulRfIDotTmlbs+dRpEEkhB5Hj09njH9NVQ9yLSzwTyYmQ
         ngmq6QqBp9qNjyD6UVwkOxkMDaj5FYIyjx0pVVP4+RGnZZQ7SSG1jqXIFfXaiAPz4LMs
         4C6w==
X-Gm-Message-State: APjAAAXf63twkF0q39lOf+hCZfajBkJETJfgUJoe4C+5GxjIlmpftifW
        VUKneZKbJrzE7LhfHzlx2jsOS6PH9ow=
X-Google-Smtp-Source: APXvYqz/m/hT1DBXSL07TGxLGVUCeN8B0kAJzvdzlJkaG2NHwbcJ+hS/VHnhk3sUO46ymfu8PHmxgw==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40mr4867576plg.239.1559239974085;
        Thu, 30 May 2019 11:12:54 -0700 (PDT)
Received: from adminPC ([27.7.15.150])
        by smtp.gmail.com with ESMTPSA id r185sm3757373pfc.167.2019.05.30.11.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 11:12:53 -0700 (PDT)
From:   Cynthia Higgins <cynthia.higgins@fortuneproleads.com>
X-Google-Original-From: "Cynthia Higgins" <Cynthia.Higgins@fortuneproleads.com>
To:     <linux-kernel@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Attendees Data Base of DAC 2019
Date:   Thu, 30 May 2019 13:12:29 -0500
Message-ID: <0e1c01d51713$4c08a4b0$e419ee10$@fortuneproleads.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUXCKSdpnJXd4gNRVCNq5WNxqSy1AACn3LAAAAAFfAAAAADUAAAAASAAAAAA7AAAAAF4AAAAANAAAAABIAAAAADsAAAAAQQAAAABEAAAAAEoAAAAATgAAAABEAAAAADcAAAAAXQAAAAAwAAAAAEcAAAAATQAAAABAAAAAAEYAAAAATQAAAABTAAAAAEkAAAAATwAAAABGA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am following up to check if you are interested in acquiring Design
Automation Conference & Exhibition 2019	
Let me know if you would like to acquire Attendees Data Base?

Attendees List:  Designers, Researchers, Tool developers, Vendors And Many
More ...
Each record in the data base contains: - Contact Name, Job Title,
Company/Business Name, Email, Tel Number, Website/URL etc.
If you are interested, please let me know your thoughts, so that I can send
you the no of contacts available and the pricing for it.
Awaiting Your Reply
Thanks & Regards,
Cynthia Higgins
Marketing Executive


