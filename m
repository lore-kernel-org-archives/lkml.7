Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F720717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZGNN3HnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLPRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:21:25 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:60732 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfLPRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:21:25 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 12:21:24 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1576515982; x=1579107982;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nQzlEhstz6bqYeYN+h83SZIKfFTISEAjbJ8cLaD25kA=;
        b=ZGNN3HnMGOKXlxf4kNrhPaoaFpxiY3TksbfgIByL/zhHW9OryxwqEaNz1+oYqX1u
        Veloku7iMZEgOyyyT3iq+xUxE+K3MvOSSVfUQAvwjrNczoxGT9ukNlpeFjB7p6FZ
        93sl1oOtqdCQm6NKJSgtWvJsWpO4/vBWmk0vrJhoSsk=;
X-AuditID: c39127d2-e0fff7000000408f-0b-5df7b98d3a6d
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8E.1C.16527.D89B7FD5; Mon, 16 Dec 2019 18:06:21 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019121618062135-25360 ;
          Mon, 16 Dec 2019 18:06:21 +0100 
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/1] regulator: of: Does always-on imply on-in-suspend?
Date:   Mon, 16 Dec 2019 18:06:20 +0100
Message-Id: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2019 18:06:21,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2019 18:06:21,
        Serialize complete at 16.12.2019 18:06:21
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJMWRmVeSWpSXmKPExsWyRoCBS7d35/dYgz3bzCymPnzCZvHtSgeT
        xeVdc9gcmD12zrrL7rFpVSebx+dNcgHMUVw2Kak5mWWpRfp2CVwZW1+sYCloY62Y3nOBuYGx
        i6WLkZNDQsBEYt6C60A2F4eQwFZGieurJrBBOOcYJeav+ssEUsUGVLW7+RYziC0ioCCxufcZ
        K4jNLOAh0fGkD8wWFnCXaJ81HayeRUBV4vjct2BxXqCal7/uQ22Tk7h5rpMZwm5kkmicKQFh
        C0mcXnyWeQIjzwJGhlWMQrmZydmpRZnZegUZlSWpyXopqZsYgd4/PFH90g7GvjkehxiZOBgP
        MUpwMCuJ8O5Q+B4rxJuSWFmVWpQfX1Sak1p8iFGag0VJnHcDb0mYkEB6YklqdmpqQWoRTJaJ
        g1OqgTFLNaRPM3HN4XPKh+a8ONhWPPXKx90Wvvvknjn1lBZ1OEz9tcO5Wd1g9cYG4z+t7pcM
        7AsOljLXbX9Zv59TcPLEgHCpK9a/fPX7hD4snVsxT9dd2kD60SpuzUwPXxn+5+t1VrRvVYhR
        yPfdyb/tis+tfekLrQ8x+FlfXfBF2ndtV9aCt5+4hZRYijMSDbWYi4oTAboxZazsAQAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Just to make sure; the oftree property regulator-always-on implies that for
every suspend state, the property regulator-on-in-suspend is implicit? With no
other side-effect? Reading the documentation, this is what I interpret.

So if that is true, the next message is a patch to fix a bogus
"No configuration" warning in the case when regulator-always-on exists and
suspend states are not set explicitly.

Robert Karszniewicz (1):
  regulator: of: Hide wrong warning regarding suspend state
    configuration

 drivers/regulator/of_regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

