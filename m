Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461EC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7C2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="hyHzEILB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfKQSq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 13:46:56 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:46254 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfKQSq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1574016415; bh=IV3Ka9wPF3Angcjuuyiejuy56Tj7kErlKLglkW4rt2Q=;
        h=In-Reply-To:Date:Cc:Subject:From:To;
        b=hyHzEILB8O1F8yJtbXq6xt+8M0QgBLeB/spfTr9tdrEm7iKdIhdtM93G8RhsJqdgd
         eUflKuO7T9/6gS29I8oHar8JLvfl9RO3Mnbznrsh3RvEgQn7xtnW3B1KFfOlfEJ03M
         sNS1ribYED0GiK9XJAahIvcKzy3DJRSlGQHWeAyE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Wed Nov 13, 2019 at 8:50 PM
Originalfrom: "Luis Chamberlain" <mcgrof@kernel.org>
Original: =?utf-8?q?On_Wed,_Nov_13,_2019_at_08:19:07PM_+0000,_Robin_H._Johnson_wrot?= =?utf-8?q?e:=0D=0A>_I_have_two_uses_cases_overall:=0D=0A>_-_log_so_you_kn?= =?utf-8?q?ow_exactly_when_it's_loaded_successfully_(great_if=0D=0A>___loa?= =?utf-8?q?ding_a_firmware_causes_your_system_to_lock_up_a_few_seconds_lat?= =?utf-8?q?er)=0D=0A=0D=0AThen_you_can_change_the_driver_to_confirm_this,_?= =?utf-8?q?not_impose_every_driver=0D=0Ato_do_the_same.=0D=0A=0D=0A>_-_at_?= =?utf-8?q?some_point_in_the_future,_being_able_to_query_what_firmware_was?= =?utf-8?q?=0D=0A>___loaded_in_the_past,_and_esp._exactly_what_version/dat?= =?utf-8?q?a_was_in_that=0D=0A>___firmware_file.=0D=0A=0D=0AFirmware_data_?= =?utf-8?q?is_opaque_to_the_firmware_loader,_as_such_details_to=0D=0Aextra?= =?utf-8?q?ct_generic_information_about_firmware_details_can_only_be_done?= =?utf-8?q?=0D=0Aby_the_driver,_which_could_decode_the_firmware_informatio?= =?utf-8?q?n._Many=0D=0Adrivers_print_these_details_themselves_already,_if?=
 =?utf-8?q?_they_want_it.=0D=0A=0D=0AA_generic_interface_to_let_us_query_*?=
 =?utf-8?q?all*_devices_and_currently_loaded=0D=0Afirmware_through_the_fir?=
 =?utf-8?q?mware_loader_would_only_be_possible_today_for=0D=0Afirmware_whi?=
 =?utf-8?q?ch_requests_(the_default)_caching_of_firmware_upon=0D=0Asuspend?=
 =?utf-8?q?/resume_given_that_we_keep_the_device_/_firmware_name_pair=0D?=
 =?utf-8?q?=0Aaround_prior_to_suspend._For_those_devices_it_could_be_possi?=
 =?utf-8?q?ble_to=0D=0Aextend_the_firmware_loader_with_a_driver_callback_w?=
 =?utf-8?q?hich_can_extract=0D=0Afirmware_details_in_a_generic_codified_wa?=
 =?utf-8?q?y._To_support_*all*_drivers=0D=0Athough,_in_a_more_clean_way_fo?=
 =?utf-8?q?r_this,_a_separate_but_similar_list=0D=0Acould_be_kept_which_en?=
 =?utf-8?q?ables_one_to_do_this._Such_items_would_be=0D=0Atorn_down_upon_d?=
 =?utf-8?q?river_removal._But_that_would_then_be_an_opt-in=0D=0Anew_mechan?=
 =?utf-8?q?ism.=0D=0A=0D=0A__Luis=0D=0A?=
In-Reply-To: <20191113205010.GY11244@42.do-not-panic.com>
Date:   Sun, 17 Nov 2019 13:46:54 -0500
Cc:     "Drew DeVault" <sir@cmpwn.com>, <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <~sircmpwn/public-inbox@lists.sr.ht>
Subject: Re: [PATCH v2] firmware loader: log path to loaded firmwares
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Message-Id: <BYIE92D2WKVP.1EQ44XBKJ98V8@homura>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new patch prepared which moves my logging into
_request_firmware. Would you prefer I send this along or would you like
to take Robin's patch?
