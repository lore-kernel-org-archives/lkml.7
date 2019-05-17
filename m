Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D34C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194A720833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JOcqkXq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfEQNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:21:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56929 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbfEQNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:21:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HDGMHk016693;
        Fri, 17 May 2019 15:21:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=hH3xJ0v8TexP7Quso2VUeFr2IlO7q7v9By4caLNd5PI=;
 b=JOcqkXq0EBNhGrX7hROB2vknY1XsUCJtByolPM9Kh/2aYDrlR2CoqOqXhqknavpWgxyg
 Qs2sSjbMmTi3r1CCEm5Zy/LNBhMAzFa1F2YEmSwyjHaIw0RNz7SRlNF5gusKygKOAoq4
 17DjbSGesVRm5I3Lx4B9lg2S40RaAlDqMYFsBGpuw9r6YiLQ54O6pqV3ymCsodYoOaig
 G6tsSEbBg1VSf5UYn3s4wRxqhI7jcr3meGdnyj5lwrwvMJIIwAc+J2x/44LyZs1stLb/
 1M6bHFJUQ3TEKwp2NjSBrkTyLcW7xBLTgMBtyt3++mwKqgss4d/9DJCjeOkCgn69/O31 tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sg0ankx6c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 17 May 2019 15:21:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBEA431;
        Fri, 17 May 2019 13:21:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C00FD2B3A;
        Fri, 17 May 2019 13:21:25 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 May
 2019 15:21:25 +0200
Subject: Re: [PATCH v2 2/2] tty: add rpmsg driver
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
 <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
 <20190516182058.2a565748@alans-desktop>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 xsFNBFZu+HIBEAC/bt4pnj18oKkUw40q1IXSPeDFOuuznWgFbjFS6Mrb8axwtnxeYicv0WAL
 rWhlhQ6W2TfKDJtkDygkfaZw7Nlsj57zXrzjVXuy4Vkezxtg7kvSLYItQAE8YFSOrBTL58Yd
 d5cAFz/9WbWGRf0o9MxFavvGQ9zkfHVd+Ytw6dJNP4DUys9260BoxKZZMaevxobh5Hnram6M
 gVBYGMuJf5tmkXD/FhxjWEZ5q8pCfqZTlN9IZn7S8d0tyFL7+nkeYldA2DdVplfXXieEEURQ
 aBjcZ7ZTrzu1X/1RrH1tIQE7dclxk5pr2xY8osNePmxSoi+4DJzpZeQ32U4wAyZ8Hs0i50rS
 VxZuT2xW7tlNcw147w+kR9+xugXrECo0v1uX7/ysgFnZ/YasN8E+osM2sfa7OYUloVX5KeUK
 yT58KAVkjUfo0OdtSmGkEkILWQLACFEFVJPz7/I8PisoqzLS4Jb8aXbrwgIg7d4NDgW2FddV
 X9jd1odJK5N68SZqRF+I8ndttRGK0o7NZHH4hxJg9jvyEELdgQAmjR9Vf0eZGNfowLCnVcLq
 s+8q3nQ1RrW5cRBgB8YT2kC8wwY5as8fhfp4846pe2b8Akh0+Vba5pXaTvtmdOMRrcS7CtF6
 Ogf9zKAxPZxTp0qGUOLE3PmSc3P3FQBLYa6Y+uS2v2iZTXljqQARAQABzSpBcm5hdWQgUG91
 bGlxdWVuIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT7CwX4EEwECACgFAlZu+HICGyMFCQlm
 AYAGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEP0ZQ+DAfqbfdXgP/RN0bU0gq3Pm1uAO
 4LejmGbYeTi5OSKh7niuFthrlgUvzR4UxMbUBk30utQAd/FwYPHR81mE9N4PYEWKWMW0T3u0
 5ASOBLpQeWj+edSE50jLggclVa4qDMl0pTfyLKOodt8USNB8aF0aDg5ITkt0euaGFaPn2kOZ
 QWVN+9a5O2MzNR3Sm61ojM2WPuB1HobbrCFzCT+VQDy4FLU0rsTjTanf6zpZdOeabt0LfWxF
 M69io06vzNSHYH91RJVl9mkIz7bYEZTBQR23KjLCsRXWfZ+54x6d6ITYZ2hp965PWuAhwWQr
 DdTJ3gPxmXJ7xK9+O15+DdUAbxF9FJXvvt9U5pTk3taTM3FIp/qaw77uxI/wniYA0dnIJRX0
 o51sjR6cCO6hwLciO7+Q0OCDCbtStuKCCCTZY5bF6fuEqgybDwvLGAokYIdoMagJu1DLKu4p
 seKgPqGZ4vouTmEp6cWMzSyRz4pf3xIJc5McsdrUTN2LtcX63E45xKaj/n0Neft/Ce7OuyLB
 rr0ujOrVlWsLwyzpU5w5dX7bzkEW1Hp4mv44EDxH9zRiyI5dNPpLf57I83Vs/qP4bpy7/Hm1
 fqbuM0wMbOquPGFI8fcYTkghntAAXMqNE6IvETzYqsPZwT0URpOzM9mho8u5+daFWWAuUXGA
 qRbo7qRs8Ev5jDsKBvGhzsFNBFZu+HIBEACrw5wF7Uf1h71YD5Jk7BG+57rpvnrLGk2s+YVW
 zmKsZPHT68SlMOy8/3gptJWgddHaM5xRLFsERswASmnJjIdPTOkSkVizfAjrFekZUr+dDZi2
 3PrISz8AQBd+uJ29jRpeqViLiV+PrtCHnAKM0pxQ1BOv8TVlkfO7tZVduLJl5mVoz1sq3/C7
 hT5ZICc2REWrfS24/Gk8mmtvMybiTMyM0QLFZvWyvNCvcGUS8s2a8PIcr+Xb3R9H0hMnYc2E
 7bc5/e39f8oTbKI6xLLFLa5yJEVfTiVksyCkzpJSHo2eoVdW0lOtIlcUz1ICgZ7vVJg7chmQ
 nPmubeBMw73EyvagdzVeLm8Y/6Zux8SRab+ZcU/ZQWNPKoW5clUvagFBQYJ6I2qEoh2PqBI4
 Wx0g1ca7ZIwjsIfWS7L3e310GITBsDmIeUJqMkfIAregf8KADPs4+L71sLeOXvjmdgTsHA8P
 lK8kUxpbIaTrGgHoviJ1IYwOvJBWrZRhdjfXTPl+ZFrJiB2E55XXogAAF4w/XHpEQNGkAXdQ
 u0o6tFkJutsJoU75aHPA4q/OvRlEiU6/8LNJeqRAR7oAvTexpO70f0Jns9GHzoy8sWbnp/LD
 BSH5iRCwq6Q0hJiEzrVTnO3bBp0WXfgowjXqR+YR86JPrzw2zjgr1e2zCZ1gHBTOyJZiDwAR
 AQABwsFlBBgBAgAPBQJWbvhyAhsMBQkJZgGAAAoJEP0ZQ+DAfqbfs5AQAJKIr2+j+U3JaMs3
 px9bbxcuxRLtVP5gR3FiPR0onalO0QEOLKkXb1DeJaeHHxDdJnVV7rCJX/Fz5CzkymUJ7GIO
 gpUGstSpJETi2sxvYvxfmTvE78D76rM5duvnGy8lob6wR2W3IqIRwmd4X0Cy1Gtgo+i2plh2
 ttVOM3OoigkCPY3AGD0ts+FbTn1LBVeivaOorezSGpKXy3cTKrEY9H5PC+DRJ1j3nbodC3o6
 peWAlfCXVtErSQ17QzNydFDOysL1GIVn0+XY7X4Bq+KpVmhQOloEX5/At4FlhOpsv9AQ30rZ
 3F5lo6FG1EqLIvg4FnMJldDmszZRv0bR0RM9Ag71J9bgwHEn8uS2vafuL1hOazZ0eAo7Oyup
 2VNRC7Inbc+irY1qXSjmq3ZrD3SSZVa+LhYfijFYuEgKjs4s+Dvk/xVL0JYWbKkpGWRz5M82
 Pj7co6u8pTEReGBYSVUBHx7GF1e3L/IMZZMquggEsixD8CYMOzahCEZ7UUwD5LKxRfmBWBgK
 36tfTyducLyZtGB3mbJYfWeI7aiFgYsd5ehov6OIBlOz5iOshd97+wbbmziYEp6jWMIMX+Em
 zqSvS5ETZydayO5JBbw7fFBd1nGVYk1WL6Ll72g+iEnqgIckMtxey1TgfT7GhPkR7hl54ZAe
 8mOik8I/F6EW8XyQAA2P
Message-ID: <28d67a7b-4b75-f2fc-3058-776b37d90622@st.com>
Date:   Fri, 17 May 2019 15:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516182058.2a565748@alans-desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

On 5/16/19 7:20 PM, Alan Cox wrote:
> 
>> +static int rpmsg_tty_data_handler(struct rpmsg_device *rpdev, void *data,
>> +				  int len, void *priv, u32 src)
>> +{
>> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
>> +	u8 *cbuf;
>> +	int space;
>> +
>> +	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
>> +
>> +	if (!len)
>> +		return 0;
>> +
>> +	dev_dbg(&rpdev->dev, "space available: %d\n",
>> +		tty_buffer_space_avail(&cport->port));
>> +
>> +	space = tty_prepare_flip_string(&cport->port, &cbuf, len);
>> +	if (space <= 0) {
>> +		dev_err(&rpdev->dev, "No memory for tty_prepare_flip_string\n");
>> +		return -ENOMEM;
>> +	}
> 
> Really bad idea.
> 
> 1. It's not an 'error'. It's normal that in the case the consumer is
> blocked you can run out of processing space
> 
> 2. You will trigger this when being hit by a very large fast flow of data
> so responding by burning CPU spewing messages (possibly even out of this
> tty) is bad.
> 
> It's not a bug - just keep statistics and throw it away. If anyone cares
> they will do flow control.

Indeed,and there is a similar issue in the rpmsg_tty_write_control (on
rpmsg_trysend failure), i will change message level to debug.
Furthermore  there is a nonsense to return error to rpmsg framework as
rpmsg reception is ok...

> 
> 
>> +
>> +static int rpmsg_tty_write_control(struct tty_struct *tty, u8 ctrl, u8 *values,
>> +				   unsigned int n_value)
>> +{
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +	struct rpmsg_tty_payload *msg;
>> +	struct rpmsg_tty_ctrl *m_ctrl;
>> +	struct rpmsg_device *rpdev;
>> +	unsigned int msg_size;
>> +	int ret;
>> +
>> +	if (!cport) {
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	msg_size = sizeof(*msg) + sizeof(*m_ctrl) + n_value;
>> +	msg = kzalloc(msg_size, GFP_KERNEL);
> 
> 
> Out of memory check ?
> 
>> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
>> +{
>> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +	struct rpmsg_device *rpdev;
>> +	int msg_size, msg_max_size, ret = 0;
>> +	int cmd_sz = sizeof(struct rpmsg_tty_payload);
>> +	u8 *tmpbuf;
>> +
>> +	if (!cport) {
>> +		dev_err(tty->dev, "cannot get cport\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* If cts not set, the message is not sent*/
>> +	if (!cport->cts)
>> +		return 0;
>> +
>> +	rpdev = cport->rpdev;
>> +
>> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
>> +		__func__, tty->index, len);
>> +	if (!buf) {
>> +		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	msg_max_size = rpmsg_get_buf_payload_size(rpdev->ept);
>> +	if (msg_max_size < 0)
>> +		return msg_max_size;
>> +
>> +	msg_size = min(len + cmd_sz, msg_max_size);
>> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
> 
> Allocation failure check ?
> 

Thanks for your comments, i will fix in a v3.

Regards
Arnaud
