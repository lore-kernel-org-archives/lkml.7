Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22804C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97E220823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfC1RqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:46:16 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:59108 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725849AbfC1RqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:46:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8DB77182CF69A;
        Thu, 28 Mar 2019 17:46:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: teeth78_193452788fd15
X-Filterd-Recvd-Size: 3816
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 17:46:13 +0000 (UTC)
Message-ID: <70abd913d4bfc6a514a99288373632f8d1ea5d87.camel@perches.com>
Subject: Re: [PATCH][next] Bluetooth: Use struct_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Mar 2019 10:46:11 -0700
In-Reply-To: <20190328173029.GA13869@embeddedor>
References: <20190328173029.GA13869@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 12:30 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> size = struct_size(instance, entry, count);
[]
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
[]
> @@ -2301,8 +2301,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>  				       MGMT_STATUS_INVALID_PARAMS);
>  	}
>  
> -	expected_len = sizeof(*cp) + key_count *
> -					sizeof(struct mgmt_link_key_info);
> +	expected_len = struct_size(cp, keys, key_count);
>  	if (expected_len != len) {
>  		bt_dev_err(hdev, "load_link_keys: expected %u bytes, got %u bytes",
>  			   expected_len, len);
> @@ -5030,7 +5029,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
>  				       MGMT_STATUS_INVALID_PARAMS);
>  	}
>  
> -	expected_len = sizeof(*cp) + irk_count * sizeof(struct mgmt_irk_info);
> +	expected_len = struct_size(cp, irks, irk_count);
>  	if (expected_len != len) {
>  		bt_dev_err(hdev, "load_irks: expected %u bytes, got %u bytes",
>  			   expected_len, len);
> @@ -5112,8 +5111,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>  				       MGMT_STATUS_INVALID_PARAMS);
>  	}
>  
> -	expected_len = sizeof(*cp) + key_count *
> -					sizeof(struct mgmt_ltk_info); 
> +	expected_len = struct_size(cp, keys, key_count);
>  	if (expected_len != len) {
>  		bt_dev_err(hdev, "load_keys: expected %u bytes, got %u bytes",
>  			   expected_len, len);
> @@ -5847,8 +5845,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>  				       MGMT_STATUS_INVALID_PARAMS);
>  	}
>  
> -	expected_len = sizeof(*cp) + param_count *
> -					sizeof(struct mgmt_conn_param);
> +	expected_len = struct_size(cp, params, param_count);
>  	if (expected_len != len) {
>  		bt_dev_err(hdev, "load_conn_param: expected %u bytes, got %u bytes",
>  			   expected_len, len);

Maybe add a helper function for all of these.
Perhaps something like:

static bool verify_len(size_t actual, size_t expected)
{
	if (actual == expected)
		return true;
	bt_dev_err("%ps: expected %zu bytes, got %zu bytes",
		   __builtin_return_address(1), expected, actual);
	return false;
}

So the last block above might be

	if (!verify_len(len, struct_size(cp, params, param_count),))
		return mgmt_cmd_status(sk, hdev->id,  MGMT_OP_LOAD_CONN_PARAM,
				       MGMT_STATUS_INVALID_PARAMS);

etc...


