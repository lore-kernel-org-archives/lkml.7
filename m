Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A43C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413DC20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2dGdU2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDAOB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:01:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44230 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDAOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:01:28 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so7781564iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lfoCLRG6HMmeIIdSl8C7+UEgWc0XcA5Wov4IW1MXoRk=;
        b=W2dGdU2qda7OAFU+4UpDoAAY73QBudcHEHR3k8VtiO0XEsYFv81G58i7+YabGKHoYw
         30+0xY6v/nQQC1dvfX6yUe+4JZB/dh+BJw8XjZpN4LGTX1ntxVG1O1zu0EQzOlYMvq0N
         nwMovaneicWVW7DGOKmv3y06PcTvmeNPmVEr9SclSUent0jIG6pSIapSyhw59Zm2lbkp
         RLjPhDRFoFBsxbgzjQlz8DU4dzO3nKfKIIBhuUOBL4xuIeooeltRy2Bq+nUqvo7YcJJn
         TcQJCcX9pFS5+wugQgiD5q/mC/rnIFpiCUfnxOv6seC99g+FwtXSiI+0tD/jBw9BlnUH
         y0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lfoCLRG6HMmeIIdSl8C7+UEgWc0XcA5Wov4IW1MXoRk=;
        b=G2jeDGK1Av9DflK3IaY1gyIHADIQH2dC87ZzegeMN6ePbutMlYPf0QZWqMYKzP0a7y
         CxTqNuWiqGJwqRiEx8DKWWO3p6OSy9erKPGg4JVDiGtYT0XYqOibIdl7ATM5+PJ2OPGT
         E697Mh6G8KzUObO8ZjhRvR6VD1fKPONMigCYHBI66KCyfuHXrT/B8nP/BqZIxDasq7gV
         QYKkzKnttRxbnkJBnCMzerojAV4TwpcOsXz4z+hxO+aKErvVrIHDormi3njko1/2Qjw4
         EEA9jPBvcW7GyU0b9Xjwhna1jEbXRrShdOqPynCZ2OAkKqe/ubF0Zf/X05r8J7fzMpu1
         ex1Q==
X-Gm-Message-State: APjAAAUEA6x3UXDcX+5hPRhL3P4ZJtWqYtUBPPA87GfVZ0AyabrWqIjR
        MW3T9GDA1GDHpII9+Z1WGPI=
X-Google-Smtp-Source: APXvYqzi2Mau0VViIoeK5N3Xq2WX1aUl5YxubS8Npdo6CNwxKIFZ9p0y3nqBN9J8tywC3QCzI6qxsw==
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr44048147iok.227.1554127287545;
        Mon, 01 Apr 2019 07:01:27 -0700 (PDT)
Received: from titus.pi.local ([66.97.27.10])
        by smtp.gmail.com with ESMTPSA id t67sm5854864ita.35.2019.04.01.07.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:01:26 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:01:30 -0400
From:   Will Cunningham <wjcunningham7@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mojha@codeaurora.org
Subject: [PATCH v2] Staging: comedi: drivers: pcl818: Fixed a coding style
 error.
Message-ID: <20190401140130.GA4311@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses.

Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
---
Changes in v2:
 - Removed a typo from the commit message.
---
 drivers/staging/comedi/drivers/pcl818.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
index 0af5315d4357..da5d53a288f7 100644
--- a/drivers/staging/comedi/drivers/pcl818.c
+++ b/drivers/staging/comedi/drivers/pcl818.c
@@ -1012,7 +1012,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		pcl818_alloc_dma(dev, it->options[2]);
 
 	/* use 1MHz or 10MHz oscilator */
-	if ((it->options[3] == 0) || (it->options[3] == 10))
+	if (it->options[3] == 0 || it->options[3] == 10)
 		osc_base = I8254_OSC_BASE_10MHZ;
 	else
 		osc_base = I8254_OSC_BASE_1MHZ;
@@ -1026,7 +1026,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	devpriv->ns_min = board->ns_min;
 	if (!board->is_818) {
 		/* extended PCL718 to 100kHz DAC */
-		if ((it->options[6] == 1) || (it->options[6] == 100))
+		if (it->options[6] == 1 || it->options[6] == 100)
 			devpriv->ns_min = 10000;
 	}
 
@@ -1067,12 +1067,12 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		s->maxdata	= 0x0fff;
 		s->range_table	= &range_unipolar5;
 		if (board->is_818) {
-			if ((it->options[4] == 1) || (it->options[4] == 10))
+			if (it->options[4] == 1 || it->options[4] == 10)
 				s->range_table = &range_unipolar10;
 			if (it->options[4] == 2)
 				s->range_table = &range_unknown;
 		} else {
-			if ((it->options[5] == 1) || (it->options[5] == 10))
+			if (it->options[5] == 1 || it->options[5] == 10)
 				s->range_table = &range_unipolar10;
 			if (it->options[5] == 2)
 				s->range_table = &range_unknown;
-- 
2.19.2

