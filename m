Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30550C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F368B222A9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="DW9l4tY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfKSO3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:29:54 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25823 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfKSO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:29:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574173758; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XJ0/7yzGtFMjaynFAdXoOWMpU2GBZZFQnt2PcAwh/Yeov1a2rG3ry+PKl5qAdYb7oJBpGD+pYgEEcHjgBeXvrp+4beGYf0kn14XIdVamqyg41AUk4D+TGNsjhKgEyvZcwFhEVwDpyJPDuW/5Y8dg85u5esHlPzVt5j22UCr2FtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574173758; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=h6PQn6Buvk9IhdaraQSPBSDfueKAFoB69+/o4wQRgnY=; 
        b=lTewGiRG58v0I66DF4/HvHQhMrh80LkNcd7L5I9HmWuZhcSxw4LzofJgXy2yceuL67668Z4JklB3PUkF45L5lKFFUrnVQfFyfkIEt5/1Ca6HzWAA0hkCVqrMdry1ab/soDMOtgq5UPMFVx3fNfwJKfcbktAeJW17e8rUCvz/uhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=eWFbwFYfDb3cZN/6+qtqj598lJbz7HURcpK7tlHeLb+y5ftRVOI+uBYcJ0PiNOaSPc/iLC7FBj69
    rGM5LpAC+r+KNNRfrFBbOaEbxUViuu8y7i6XO2158zhOKlLFpupT  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574173758;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=71;
        bh=h6PQn6Buvk9IhdaraQSPBSDfueKAFoB69+/o4wQRgnY=;
        b=DW9l4tY4JNmQ9qOHM1P6YfWKW8hABBaV29nDO4Js9Ny9c5VrpY9PaFcnbk9S4BB5
        y7hHh62JoEvDj0ZEGT5Q1WSqKO1Ms/7uxoUILyVYPLDHYcE6Pl2WBWwKJCjMqT8T8OB
        jnSK7AqddMTG+8bSWqFkHU7s1BgZyyglxPFKttVs=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.113.24 [171.221.113.24]) by mx.zohomail.com
        with SMTPS id 1574173757766209.66774522585627; Tue, 19 Nov 2019 06:29:17 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        paulburton@kernel.org, jhogan@kernel.org, paul@crapouillou.net,
        jiaxun.yang@flygoat.com, gregkh@linuxfoundation.org,
        malat@debian.org, tglx@linutronix.de, chenhc@lemote.com
Subject: MIPS: Ingenic: Disable abandoned HPTLB function v3.
Date:   Tue, 19 Nov 2019 22:28:45 +0800
Message-Id: <1574173727-123321-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571909341-10108-1-git-send-email-zhouyanjie@zoho.com>
References: <1571909341-10108-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
Add comment and commit message as required by Paul Cercueil.


